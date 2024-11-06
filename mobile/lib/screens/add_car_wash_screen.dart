import 'package:flutter/material.dart';
import '../models/car_wash.dart';
import '../models/service.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_notification.dart';
import '../services/car_wash_service.dart';
import '../utils/api.dart';

class AddCarWashScreen extends StatefulWidget {
  final Function(CarWash) onAddCarWash;

  const AddCarWashScreen({super.key, required this.onAddCarWash});

  @override
  AddCarWashScreenState createState() => AddCarWashScreenState();
}

class AddCarWashScreenState extends State<AddCarWashScreen> {
  final List<Service> _services = [];

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cepController = TextEditingController();
  final _serviceNameController = TextEditingController();
  final _servicePriceController = TextEditingController();
  final _serviceDurationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _serviceError = false;
  String? _notificationMessage;
  bool _isErrorNotification = false;

  final CarWashService _carWashService = CarWashService();

  void _showNotification(String message, bool isError) {
    setState(() {
      _notificationMessage = message;
      _isErrorNotification = isError;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _notificationMessage = null;
      });
    });
  }

  Future<void> _saveCarWash() async {
    if (_formKey.currentState!.validate()) {
      if (_services.isEmpty) {
        setState(() {
          _serviceError = true;
        });
      } else {
        setState(() {
          _serviceError = false;
        });

        CarWash newCarWash = CarWash(
          id: IdService.generateId(),
          name: _nameController.text,
          address: _addressController.text,
          cep: _cepController.text,
          services: _services,
        );

        try {
          await _carWashService.create(newCarWash.toJson());
          widget.onAddCarWash(newCarWash);
          _showNotification('Lava Rápido salvo com sucesso!', false);
          Navigator.pop(context);
        } catch (e) {
          _showNotification('Erro ao salvar o Lava Rápido: $e', true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Lava Rápido'),
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Lava Rápido',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nome não pode ser vazio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Endereço',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Endereço não pode ser vazio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cepController,
                    decoration: const InputDecoration(
                      labelText: 'CEP',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      final cepRegex = RegExp(r'^\d{5}-\d{3}$');
                      if (value == null || !cepRegex.hasMatch(value)) {
                        return 'CEP inválido. Formato: 12345-678';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Adicionar Serviços',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _serviceNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Serviço',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _servicePriceController,
                    decoration: const InputDecoration(
                      labelText: 'Preço',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _serviceDurationController,
                    decoration: const InputDecoration(
                      labelText: 'Duração do Serviço (ex: 1h30m)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'Adicionar Serviço',
                    backgroundColor: Colors.green,
                    onPressed: () {
                      _services.add(
                        Service(
                          id: IdService.generateId(),
                          name: _serviceNameController.text,
                          price: double.parse(_servicePriceController.text),
                          duration: _serviceDurationController.text,
                        ),
                      );
                      setState(() {});
                      _serviceNameController.clear();
                      _servicePriceController.clear();
                      _serviceDurationController.clear();
                    },
                  ),
                  const SizedBox(height: 20),
                  if (_serviceError)
                    const Text(
                      'Adicione ao menos um serviço!',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  Expanded(
                    child: _services.isNotEmpty
                        ? ListView.builder(
                            itemCount: _services.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListTile(
                                  title: Text(_services[index].name),
                                  subtitle: Text(
                                    'Preço: R\$ ${_services[index].price.toStringAsFixed(2)}\nDuração: ${_services[index].duration}',
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        _services.removeAt(index);
                                      });
                                      _showNotification(
                                          'Serviço removido com sucesso!',
                                          true);
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'Nenhum serviço adicionado ainda.',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: 'Salvar Lava Rápido',
                    backgroundColor: Colors.blue,
                    onPressed: _saveCarWash,
                  ),
                ],
              ),
            ),
          ),
          if (_notificationMessage != null)
            CustomNotification(
              message: _notificationMessage!,
              isError: _isErrorNotification,
            ),
        ],
      ),
    );
  }
}

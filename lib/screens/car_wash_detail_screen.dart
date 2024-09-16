import 'package:flutter/material.dart';
import '../models/car_wash.dart';
import '../models/service.dart';
import '../widgets/custom_drawer.dart';

class CarWashDetailScreen extends StatefulWidget {
  const CarWashDetailScreen({super.key});

  @override
  _CarWashDetailScreenState createState() => _CarWashDetailScreenState();
}

class _CarWashDetailScreenState extends State<CarWashDetailScreen> {
  final List<Service> _selectedServices = [];

  @override
  Widget build(BuildContext context) {
    final CarWash carWash =
        ModalRoute.of(context)!.settings.arguments as CarWash;

    return Scaffold(
      appBar: AppBar(
        title: Text(carWash.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              carWash.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Endereço: ${carWash.address}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'CEP: ${carWash.cep}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Serviços Disponíveis',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: carWash.services.length,
                itemBuilder: (context, index) {
                  final service = carWash.services[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CheckboxListTile(
                      title: Text(service.name),
                      subtitle: Text(
                        'Preço: R\$ ${service.price.toStringAsFixed(2)}\nDuração: ${service.duration}',
                      ),
                      value: _selectedServices.contains(service),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedServices.add(service);
                          } else {
                            _selectedServices.remove(service);
                          }
                        });
                      },
                      secondary: const Icon(
                        Icons.cleaning_services,
                        size: 40,
                        color: Colors.blueAccent,
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _selectedServices.isNotEmpty
                  ? () {
                      Navigator.pushNamed(
                        context,
                        '/schedule', // Navega para a tela de agendamento
                        arguments: _selectedServices,
                      );
                    }
                  : null, // Desabilita o botão se nenhum serviço for selecionado
              child: const Text('Prosseguir para Agendamento'),
            ),
          ],
        ),
      ),
    );
  }
}

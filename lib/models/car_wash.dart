import 'package:cleancar/utils/api.dart';

import 'service.dart';

class CarWash {
  String id;
  String name;
  String address;
  String cep;
  List<Service> services;

  CarWash({
    String? id,
    required this.name,
    required this.address,
    required this.cep,
    required this.services,
  }) : id = id ?? IdService.generateId() {
    _validateName(name);
    _validateAddress(address);
    _validateCep(cep);
    _validateServices(services);
  }

  void _validateName(String name) {
    if (name.isEmpty) {
      throw ArgumentError('Nome não pode ser vazio');
    }
  }

  void _validateAddress(String address) {
    if (address.isEmpty) {
      throw ArgumentError('Endereço não pode ser vazio');
    }
  }

  void _validateCep(String cep) {
    final cepRegex = RegExp(r'^\d{5}-\d{3}$');
    if (!cepRegex.hasMatch(cep)) {
      throw ArgumentError('CEP inválido. Deve estar no formato 12345-678');
    }
  }

  void _validateServices(List<Service> services) {
    if (services.isEmpty) {
      throw ArgumentError('A lista de serviços não pode ser vazia');
    }
  }
}

import 'package:cleancar/models/service.dart';

class CarWash {
  final String id;
  final String name;
  final String address;
  final String cep;
  final List<Service> services;

  CarWash({
    required this.id,
    required this.name,
    required this.address,
    required this.cep,
    required this.services,
  });

  factory CarWash.fromJson(Map<String, dynamic> json) {
    return CarWash(
      id: json['id'],
      name: json['name'] ?? 'Sem nome',
      address: json['address'] ?? 'Sem endereço',
      cep: json['cep'] ?? 'Sem CEP',
      services: (json['services'] as List<dynamic>?)
              ?.map((service) =>
                  Service.fromJson(service as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'cep': cep,
      'services': services.map((service) => service.toJson()).toList(),
    };
  }
}

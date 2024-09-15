import 'package:cleancar/utils/api.dart';

class Service {
  String id;
  String name;
  double price;
  String duration;

  Service({
    String? id,
    required this.name,
    required this.price,
    required this.duration,
  }) : id = id ?? IdService.generateId() {
    _validateName(name);
    _validatePrice(price);
    _validateDuration(duration);
  }

  void _validateName(String name) {
    if (name.isEmpty) {
      throw ArgumentError('Nome não pode ser vazio');
    }
  }

  void _validatePrice(double price) {
    if (price <= 0) {
      throw ArgumentError('Preço deve ser maior que zero');
    }
  }

  void _validateDuration(String duration) {
    if (duration.isEmpty) {
      throw ArgumentError('Duração não pode ser vazia');
    }
  }
}

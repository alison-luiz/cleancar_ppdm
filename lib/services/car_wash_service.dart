import 'package:flutter/material.dart';
import '../models/service.dart';

class CarWashService {
  static String? validateServiceFields(
      String name, String price, String duration) {
    if (name.isEmpty) {
      return 'Nome do serviço não pode ser vazio';
    }

    if (price.isEmpty ||
        double.tryParse(price) == null ||
        double.parse(price) <= 0) {
      return 'Preço deve ser maior que zero e válido';
    }

    if (duration.isEmpty) {
      return 'Duração não pode ser vazia';
    }

    return null;
  }

  static void addService({
    required List<Service> services,
    required String name,
    required String price,
    required String duration,
    required BuildContext context,
    required Function(String message, bool isError) showNotification,
  }) {
    final validationError = validateServiceFields(name, price, duration);

    if (validationError != null) {
      showNotification(validationError, true);
      return;
    }

    services.add(Service(
      name: name,
      price: double.parse(price),
      duration: duration,
    ));

    showNotification('Serviço adicionado com sucesso!', false);
  }
}

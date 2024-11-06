import 'package:flutter_test/flutter_test.dart';
import 'package:cleancar/models/car_wash.dart';
import 'package:cleancar/models/service.dart';

void main() {
  test('CarWash toJson returns correct JSON map', () {
    final service = Service(
        id: '1', name: 'Lavagem Completa', price: 100.0, duration: '2h');
    final carWash = CarWash(
      id: '1',
      name: 'Lava Jato Rápido',
      address: 'Rua das Flores, 123',
      cep: '12345-678',
      services: [service],
    );

    final json = carWash.toJson();
    expect(json['id'], '1');
    expect(json['name'], 'Lava Jato Rápido');
    expect(json['address'], 'Rua das Flores, 123');
    expect(json['cep'], '12345-678');
    expect(json['services'][0]['name'], 'Lavagem Completa');
  });
}

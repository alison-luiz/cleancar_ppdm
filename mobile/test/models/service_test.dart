import 'package:flutter_test/flutter_test.dart';
import 'package:cleancar/models/service.dart';

void main() {
  test('Service fromJson creates Service object from JSON', () {
    final json = {
      'id': '1',
      'name': 'Lavagem Completa',
      'price': 100.0,
      'duration': '2h'
    };

    final service = Service.fromJson(json);
    expect(service.id, '1');
    expect(service.name, 'Lavagem Completa');
    expect(service.price, 100.0);
    expect(service.duration, '2h');
  });
}

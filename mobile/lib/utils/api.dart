import 'dart:math';

class IdService {
  static final Random _random = Random();

  static String generateId() {
    const int length = 16;
    const String chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(
        length, (index) => chars[_random.nextInt(chars.length)]).join();
  }
}

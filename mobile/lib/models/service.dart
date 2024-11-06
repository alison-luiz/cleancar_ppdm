class Service {
  final String id;
  final String name;
  final double price;
  final String duration;

  Service({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'duration': duration,
    };
  }
}

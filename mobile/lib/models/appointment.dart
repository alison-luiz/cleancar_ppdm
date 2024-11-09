class Appointment {
  final String serviceId;
  final String serviceName;
  final DateTime date;
  final String time;

  Appointment({
    required this.serviceId,
    required this.serviceName,
    required this.date,
    required this.time,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      date: DateTime.parse(json['date']),
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'date': date.toIso8601String(),
      'time': time,
    };
  }
}

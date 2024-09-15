// Esta será o futuro model onde sera armazenado os dados de uma reserva de um lava rápido.

class Booking {
  String carWashId;
  DateTime date;
  String status;

  Booking({
    required this.carWashId,
    required this.date,
    required this.status,
  });
}

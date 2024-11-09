import 'package:cleancar/services/abstract_api.dart';

class AppointmentService extends AbstractApi {
  AppointmentService() : super('appointments');

  Future<String> createAppointment(Map<String, dynamic> appointment) async {
    return await create(appointment);
  }

  Future<String> getAllAppointments() async {
    return await getAll();
  }
}

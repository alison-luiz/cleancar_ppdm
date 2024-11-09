import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../services/appointment_service.dart';
import '../widgets/custom_drawer.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  _AppointmentListScreenState createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  final AppointmentService _appointmentService = AppointmentService();
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      String response = await _appointmentService.getAllAppointments();
      List<dynamic> appointmentsData = jsonDecode(response);
      setState(() {
        appointments =
            appointmentsData.map((data) => Appointment.fromJson(data)).toList();
      });
    } catch (e) {
      print("Erro ao carregar os agendamentos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Serviços Agendados'),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: appointments.isNotEmpty
            ? ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final appointment = appointments[index];
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(appointment.serviceName),
                      subtitle: Text(
                        'Data: ${appointment.date}\n'
                        'Horário: ${appointment.time}',
                      ),
                      leading: const Icon(Icons.event,
                          color: Colors.blueAccent, size: 40),
                    ),
                  );
                },
              )
            : const Center(
                child: Text(
                  'Nenhum serviço agendado ainda.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
      ),
    );
  }
}

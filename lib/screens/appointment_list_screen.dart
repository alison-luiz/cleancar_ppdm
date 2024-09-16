import 'package:cleancar/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import '../models/appointment.dart';

class AppointmentListScreen extends StatelessWidget {
  final List<Appointment> appointments;

  const AppointmentListScreen({super.key, required this.appointments});

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

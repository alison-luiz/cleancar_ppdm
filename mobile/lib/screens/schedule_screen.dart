import 'package:flutter/material.dart';
import '../models/service.dart';
import '../models/appointment.dart';
import '../services/appointment_service.dart';
import '../widgets/custom_button.dart';

class ScheduleScreen extends StatefulWidget {
  final List<Service> selectedServices;
  final Function(Appointment) onAddAppointment;

  const ScheduleScreen(
      {super.key,
      required this.selectedServices,
      required this.onAddAppointment});

  @override
  ScheduleScreenState createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> {
  DateTime? _selectedDate;
  String? _selectedTime;
  final AppointmentService _appointmentService = AppointmentService();

  final List<String> _availableTimes = [
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
  ];

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar Lava Rápido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione a Data',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedDate != null
                          ? 'Data Selecionada: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                          : 'Nenhuma data selecionada',
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.black54),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Selecione o Horário',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton<String>(
                hint: const Text(
                  'Selecione o horário',
                  style: TextStyle(color: Colors.black54),
                ),
                value: _selectedTime,
                isExpanded: true,
                underline: Container(),
                items: _availableTimes.map((time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(
                      time,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTime = newValue;
                  });
                },
              ),
            ),
            const Spacer(),
            Center(
              child: CustomButton(
                text: 'Confirmar Agendamento',
                backgroundColor: Colors.green,
                enabled: _selectedDate != null && _selectedTime != null,
                onPressed: () async {
                  if (_selectedDate != null && _selectedTime != null) {
                    final appointment = Appointment(
                      serviceId: widget.selectedServices.first.id,
                      serviceName: widget.selectedServices.first.name,
                      date: _selectedDate!,
                      time: _selectedTime!,
                    );

                    await _appointmentService
                        .createAppointment(appointment.toJson());

                    widget.onAddAppointment(appointment);
                    Navigator.pushNamed(context, '/appointments');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

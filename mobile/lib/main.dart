import 'dart:convert';
import 'package:cleancar/models/appointment.dart';
import 'package:cleancar/screens/appointment_list_screen.dart';
import 'package:cleancar/screens/schedule_screen.dart';
import 'package:cleancar/services/car_wash_service.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/car_wash_list_screen.dart';
import 'screens/add_car_wash_screen.dart';
import 'screens/car_wash_detail_screen.dart';
import 'models/car_wash.dart';
import 'models/service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<CarWash> carWashes = [];
  List<Appointment> appointments = [];

  late final CarWashService carWashService;

  @override
  void initState() {
    super.initState();
    carWashService = CarWashService();
    fetchCarWashes();
  }

  Future<void> fetchCarWashes() async {
    try {
      String response = await carWashService.getAll();
      List<dynamic> carWashesData = jsonDecode(response);
      setState(() {
        carWashes =
            carWashesData.map((data) => CarWash.fromJson(data)).toList();
      });
    } catch (e) {
      print("Erro ao carregar os lava-rápidos: $e");
    }
  }

  void addAppointment(Appointment appointment) {
    setState(() {
      appointments.add(appointment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CleanCar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/list': (context) => CarWashListScreen(carWashes: carWashes),
        '/add': (context) => AddCarWashScreen(
              onAddCarWash: (carWash) {
                setState(() {
                  carWashes.add(carWash);
                });
              },
            ),
        '/detail': (context) => const CarWashDetailScreen(),
        '/schedule': (context) => ScheduleScreen(
              selectedServices:
                  ModalRoute.of(context)!.settings.arguments as List<Service>,
              onAddAppointment: addAppointment,
            ),
        '/appointments': (context) => const AppointmentListScreen(),
      },
    );
  }
}

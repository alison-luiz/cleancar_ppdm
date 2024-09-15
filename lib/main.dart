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

  @override
  void initState() {
    super.initState();

    carWashes = [
      CarWash(
        id: '1',
        name: 'Lava Jato Rápido',
        address: 'Rua das Flores, 123',
        cep: '12345-678',
        services: [
          Service(name: 'Lavagem Completa', price: 100.00, duration: '2h'),
          Service(name: 'Lavagem Simples', price: 50.00, duration: '1h'),
        ],
      ),
      CarWash(
        id: '2',
        name: 'Lava Rápido Premium',
        address: 'Av. Brasil, 987',
        cep: '98765-432',
        services: [
          Service(name: 'Lavagem com Cera', price: 150.00, duration: '2h30m'),
          Service(name: 'Lavagem Simples', price: 60.00, duration: '1h'),
        ],
      ),
      CarWash(
        id: '3',
        name: 'Lava Jato Econômico',
        address: 'Rua dos Pássaros, 321',
        cep: '54321-876',
        services: [
          Service(name: 'Lavagem Completa', price: 80.00, duration: '2h'),
          Service(name: 'Lavagem Interna', price: 40.00, duration: '1h'),
        ],
      ),
    ];
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
      },
    );
  }
}

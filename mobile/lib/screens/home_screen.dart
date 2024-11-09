import 'package:flutter/material.dart';
import '../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2193b0),
                  Color(0xFF6dd5ed),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.car_repair,
                  size: 150,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Text(
                  'CleanCar',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white.withOpacity(0.9),
                    shadows: const [
                      Shadow(
                        blurRadius: 8.0,
                        color: Colors.black45,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Seu app de agendamento de lava rápidos',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/list');
                  },
                  child: Text(
                    'Lista de Lava Rápidos',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey[900],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

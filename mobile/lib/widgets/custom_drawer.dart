import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Lava Rápidos'),
            onTap: () {
              Navigator.pushNamed(context, '/list');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Adicionar Lava Rápido'),
            onTap: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Serviços Agendados'),
            onTap: () {
              Navigator.pushNamed(context, '/appointments');
            },
          ),
        ],
      ),
    );
  }
}

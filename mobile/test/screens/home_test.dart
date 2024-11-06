import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cleancar/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen displays main elements and navigates to list',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(),
        routes: {
          '/list': (context) => const Scaffold(
                body: Center(child: Text('Lista de Lava Rápidos')),
              ),
        },
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.byIcon(Icons.car_repair), findsOneWidget);
    expect(find.text('CleanCar'), findsOneWidget);
    expect(find.text('Seu app de agendamento de lava rápidos'), findsOneWidget);
    expect(find.text('Ver Lava Rápidos'), findsOneWidget);

    await tester.tap(find.text('Ver Lava Rápidos'));
    await tester.pumpAndSettle();

    expect(find.text('Lista de Lava Rápidos'), findsOneWidget);
  });
}

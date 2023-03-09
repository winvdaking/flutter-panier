import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/fruitmaster.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Fruit> fruits = [
    Fruit('Ananas', 2, Colors.orange, '../images/ananas.png'),
    Fruit('Banane', 0.94, Colors.yellow, '../images/banane.png'),
    Fruit('Cassis', 4, Colors.purple, '../images/cassis.png'),
    Fruit('Citron Vert', 2.49, Colors.green, '../images/citron-vert.png'),
    Fruit('Citron', 3.69, Colors.yellow, '../images/citron.png'),
    Fruit('Fraise', 1.78, Colors.red, '../images/fraise.png'),
    Fruit('Framboise', 1.82, Colors.purple, '../images/framboise.png'),
    Fruit('Fruit de la passion', 9.99, Colors.deepOrange,
        '../images/fruit-de-la-passion.png'),
    Fruit('Grenade', 1.13, Colors.red, '../images/grenade.png'),
    Fruit('Kaki', 5, Colors.brown, '../images/kaki.png'),
    Fruit('Kiwi', 2.50, Colors.green, '../images/kiwi.png'),
    Fruit('Litchi', 1.99, Colors.pink, '../images/litchi.png'),
    Fruit('Mangue', 4.99, Colors.deepOrange, '../images/mangue.png'),
    Fruit('Mure', 0.99, Colors.purple, '../images/mure.png'),
    Fruit('Myrtille', 3.99, Colors.pink, '../images/myrtille.png'),
    Fruit('Orange', 3, Colors.orange, '../images/orange.png'),
    Fruit('Pasteque', 7.33, Colors.lightGreen, '../images/pasteque.png'),
    Fruit('Peche', 2.09, Colors.orange, '../images/peche.png')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Panier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FruitMaster(
        title: 'Total panier :',
        lesFruits: fruits,
      ),
    );
  }
}

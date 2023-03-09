import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/fruitmaster.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Fruit> fruits = [];

  // final List<Fruit> fruits = [
  //   Fruit('Ananas', 2, Colors.orange, '../images/ananas.png', 20),
  //   Fruit('Banane', 0.94, Colors.yellow, '../images/banane.png', 10),
  //   Fruit('Cassis', 4, Colors.purple, '../images/cassis.png', 19),
  //   Fruit('Citron Vert', 2.49, Colors.green, '../images/citron-vert.png', 8),
  //   Fruit('Citron', 3.69, Colors.yellow, '../images/citron.png', 18),
  //   Fruit('Fraise', 1.78, Colors.red, '../images/fraise.png', 32),
  //   Fruit('Framboise', 1.82, Colors.purple, '../images/framboise.png', 29),
  //   Fruit('Fruit de la passion', 9.99, Colors.deepOrange,
  //       '../images/fruit-de-la-passion.png', 3),
  //   Fruit('Grenade', 1.13, Colors.red, '../images/grenade.png', 9),
  //   Fruit('Kaki', 5, Colors.brown, '../images/kaki.png', 2),
  //   Fruit('Kiwi', 2.50, Colors.green, '../images/kiwi.png', 12),
  //   Fruit('Litchi', 1.99, Colors.pink, '../images/litchi.png', 7),
  //   Fruit('Mangue', 4.99, Colors.deepOrange, '../images/mangue.png', 5),
  //   Fruit('Mure', 0.99, Colors.purple, '../images/mure.png', 23),
  //   Fruit('Myrtille', 3.99, Colors.pink, '../images/myrtille.png', 25),
  //   Fruit('Orange', 3, Colors.orange, '../images/orange.png', 9),
  //   Fruit('Pasteque', 7.33, Colors.lightGreen, '../images/pasteque.png', 3),
  //   Fruit('Peche', 2.09, Colors.orange, '../images/peche.png', 13)
  // ];

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

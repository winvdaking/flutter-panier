import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/fruitmaster.dart';
import 'package:panier/screens/cartscreen.dart';
import 'package:panier/screens/fruitdetail.dart';
import 'package:provider/provider.dart';
import 'package:panier/providers/cartprovider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
      create: (context) => CartProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Fruit> fruits = [];
  final CartProvider cart = CartProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) =>
            FruitMaster(title: 'Total panier :', lesFruits: fruits),
        '/details': (context) =>
            FruitDetailsScreen(unFruit: cart.getFruitDetail()),
        '/panier': (context) => CartScreen()
      },
      title: 'Flutter Demo Panier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

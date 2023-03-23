import 'package:flutter/material.dart';
import 'package:panier/class/fruit.dart';
import 'package:panier/forms/login.dart';
import 'package:panier/forms/logout.dart';
import 'package:panier/fruitmaster.dart';
import 'package:panier/providers/userprovider.dart';
import 'package:panier/screens/cartscreen.dart';
import 'package:provider/provider.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:panier/forms/register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
    ],
    child: MyApp(),
  ));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Fruit> fruits = [];
  CartProvider cart = CartProvider();

  @override
  Widget build(BuildContext context) {
    cart = context.watch<CartProvider>();
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Consumer<CartProvider>(
              builder: (context, cart, child) {
                return Consumer<UserProvider>(
                  builder: (context, user, child) {
                    return FruitMaster(
                        title: 'Total panier : 0€', lesFruits: fruits);
                  },
                );
              },
            ),
        '/panier': (context) => Consumer<CartProvider>(
              builder: (context, cart, child) {
                return Consumer<UserProvider>(
                  builder: (context, user, child) {
                    return CartScreen();
                  },
                );
              },
            ),
        '/register': (context) => Consumer<UserProvider>(
              builder: (context, user, child) {
                return const RegisterForm();
              },
            ),
        '/login': (context) => Consumer<UserProvider>(
              builder: (context, user, child) {
                return const LoginForm();
              },
            ),
        '/logout': (context) => Consumer<UserProvider>(
              builder: (context, user, child) {
                return const LogoutForm();
              },
            ),
      },
      title: 'Flutter Panier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

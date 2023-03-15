import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/providers/cartprovider.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final CartProvider cart = CartProvider();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cart.fruits.length,
      itemBuilder: (context, index) {
        // List<Fruit> lesFruitsQte = [];

        // cart.forEach((k, v) {
        //   lesFruitsQte.add(v[0]);
        // });

        Fruit currentFruit = cart.fruits[index];

        return ListTile(
            tileColor: currentFruit.color,
            title: Text("${currentFruit.name} ()"),
            hoverColor: const Color.fromRGBO(0, 0, 0, .5),
            leading: Image.asset(currentFruit.url),
            trailing: const Icon(Icons.delete),
            onTap: () => cart.removeOneFruit(currentFruit));
      },
    );
  }
}

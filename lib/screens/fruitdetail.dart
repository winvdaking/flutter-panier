import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';

import '../providers/cartprovider.dart';

// ignore: must_be_immutable
class FruitDetailsScreen extends StatelessWidget {
  FruitDetailsScreen({super.key, required this.unFruit});

  final CartProvider cart = CartProvider();
  final Fruit unFruit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(unFruit.url, height: 50, width: 50)),
        Padding(padding: const EdgeInsets.all(3), child: Text(unFruit.name)),
        Padding(
            padding: const EdgeInsets.all(3), child: Text("${unFruit.price}€")),
        Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
              onPressed: () => cart.add(unFruit),
              child: const Text('Ajouter ce fruit au panier')),
        ),
        Padding(
            padding: const EdgeInsets.all(46),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, '/' as Route<Object?>);
              },
              child: const Text("Revenir au panier"),
            )),
      ],
    );
  }
}

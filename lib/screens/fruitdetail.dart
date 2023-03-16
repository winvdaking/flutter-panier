import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:provider/provider.dart';

class FruitDetailsScreen extends StatelessWidget {
  FruitDetailsScreen({super.key, required this.unFruit});

  final CartProvider cart = CartProvider();
  final Fruit unFruit;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(unFruit.name),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/panier');
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(unFruit.url, height: 50, width: 50)),
            Padding(
                padding: const EdgeInsets.all(3), child: Text(unFruit.name)),
            Padding(
                padding: const EdgeInsets.all(3),
                child: Text("${unFruit.price}€")),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                  onPressed: () {
                    cart.add(unFruit);
                    var msg = SnackBar(
                      content: Text(
                          "${unFruit.name} vient d'être ajouté(e) au panier !"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(msg);
                  },
                  child: const Text('Ajouter ce fruit au panier')),
            )
          ],
        ),
      ),
    );
  }
}

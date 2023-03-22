import 'package:flutter/material.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:panier/screens/fruitdetail.dart';
import 'package:provider/provider.dart';
import 'class/fruit.dart';

// ignore: must_be_immutable
class FruitPreview extends StatelessWidget {
  FruitPreview({super.key, required this.unFruit});

  CartProvider cart = CartProvider();

  final Fruit unFruit;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    return ListTile(
      tileColor: unFruit.color,
      title: Text(unFruit.name),
      hoverColor: const Color.fromRGBO(0, 0, 0, .5),
      leading: Image.asset(unFruit.url),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Consumer<CartProvider>(
              builder: (context, cart, child) {
                return FruitDetailsScreen(unFruit: unFruit);
              },
            ),
          ),
        );
      },
      trailing: IconButton(
        onPressed: () {
          cart.add(unFruit);
          var msg = SnackBar(
            content: Text("${unFruit.name} vient d'être ajouté(e) au panier !"),
          );
          ScaffoldMessenger.of(context).showSnackBar(msg);
        },
        icon: const Icon(Icons.add_circle_outline_outlined),
      ),
    );
  }
}

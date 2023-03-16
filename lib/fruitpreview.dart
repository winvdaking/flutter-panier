import 'package:flutter/material.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:panier/screens/fruitdetail.dart';
import 'package:provider/provider.dart';
import 'class/fruit.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview({super.key, required this.unFruit});

  final Fruit unFruit;

  @override
  Widget build(BuildContext context) {
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
      trailing: const Icon(Icons.more_vert),
    );
  }
}

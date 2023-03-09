import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen(
      {super.key,
      required this.lesFruitsDansLePanier,
      required this.pageController,
      required this.removeFruitPanier});

  final List<Fruit> lesFruitsDansLePanier;
  late PageController pageController;
  final Function removeFruitPanier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lesFruitsDansLePanier.length,
      itemBuilder: (context, index) {
        final Fruit currentFruit = lesFruitsDansLePanier[index];
        return ListTile(
            tileColor: currentFruit.color,
            title: Text(currentFruit.name),
            hoverColor: const Color.fromRGBO(0, 0, 0, .5),
            leading: Image.asset(currentFruit.url),
            trailing: const Icon(Icons.delete),
            onTap: () => removeFruitPanier(currentFruit));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen(
      {super.key,
      required this.lesFruitsDansLePanier,
      required this.pageController,
      required this.removeFruitPanier});

  final Map lesFruitsDansLePanier;
  late PageController pageController;
  final Function removeFruitPanier;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lesFruitsDansLePanier.length,
      itemBuilder: (context, index) {
        List<Fruit> lesFruitsQte = [];

        lesFruitsDansLePanier.forEach((k, v) {
          lesFruitsQte.add(v[0]);
        });

        Fruit currentFruit = lesFruitsQte[index];
        int qte = lesFruitsDansLePanier[currentFruit.name][1];

        return ListTile(
            tileColor: currentFruit.color,
            title: Text("${currentFruit.name} ($qte)"),
            hoverColor: const Color.fromRGBO(0, 0, 0, .5),
            leading: Image.asset(currentFruit.url),
            trailing: const Icon(Icons.delete),
            onTap: () => removeFruitPanier(currentFruit));
      },
    );
  }
}

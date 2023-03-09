import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';

// ignore: must_be_immutable
class FruitDetailsScreen extends StatelessWidget {
  FruitDetailsScreen(
      {super.key,
      required this.fruit,
      required this.pageController,
      required this.addPanier});

  final Fruit fruit;
  late PageController pageController;
  final Function addPanier;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(fruit.url, height: 50, width: 50)),
        Padding(padding: const EdgeInsets.all(3), child: Text(fruit.name)),
        Padding(
            padding: const EdgeInsets.all(3), child: Text("${fruit.price}€")),
        Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
              onPressed: () => addPanier(fruit),
              child: const Text('Ajouter ce fruit au panier')),
        ),
        Padding(
            padding: const EdgeInsets.all(46),
            child: ElevatedButton(
              onPressed: () {
                if (pageController.hasClients) {
                  pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: const Text("Revenir au panier"),
            )),
      ],
    );
  }
}

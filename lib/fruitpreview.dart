import 'package:flutter/material.dart';
import 'fruit.dart';

class FruitPreview extends StatelessWidget {
  const FruitPreview(
      {super.key,
      required this.unFruit,
      required this.onFruitClick,
      required this.pageController});

  final Fruit unFruit;
  final Function onFruitClick;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: unFruit.color,
      title: Text(unFruit.name),
      hoverColor: const Color.fromRGBO(0, 0, 0, .5),
      leading: Image.asset(unFruit.url),
      onTap: () {
        if (pageController.hasClients) {
          pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        }
        onFruitClick(unFruit);
      },
      trailing: const Icon(Icons.more_vert),
    );
  }
}

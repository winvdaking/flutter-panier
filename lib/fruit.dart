import 'package:flutter/material.dart';

class Fruit {
  final String name;
  final num price;
  final MaterialColor color;

  Fruit(this.name, this.price, this.color);
}


class FruitWidget extends StatelessWidget {
  const FruitWidget({super.key});

  @override
  Widget build(BuildContext context) {}
}

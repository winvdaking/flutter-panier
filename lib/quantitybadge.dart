import 'package:flutter/material.dart';
import 'package:panier/providers/cartprovider.dart';

import 'class/fruit.dart';

// ignore: must_be_immutable
class QuantityBadge extends StatelessWidget {
  QuantityBadge({super.key, required this.unFruit});

  final Fruit unFruit;
  CartProvider cart = CartProvider();

  @override
  Widget build(BuildContext context) {
    return Badge(
      backgroundColor: Colors.red,
      textColor: Colors.white,
      child: Text(cart.nbFruitInCart(unFruit) as String),
    );
  }
}

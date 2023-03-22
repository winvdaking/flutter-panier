import 'package:flutter/material.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:provider/provider.dart';

import 'class/fruit.dart';

// ignore: must_be_immutable
class QuantityBadge extends StatelessWidget {
  QuantityBadge({super.key, required this.unFruit});

  final Fruit unFruit;
  CartProvider cart = CartProvider();

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    return Text(cart.nbFruitInCart(unFruit));
  }
}

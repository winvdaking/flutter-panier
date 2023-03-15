import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';

class CartProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Fruit> _fruits = [];
  late Fruit _fruitDetail = Fruit(
      id: 0,
      name: '',
      color: Colors.black,
      price: 0,
      quantiteStock: 0,
      url: '',
      season: '');

  /// An unmodifiable view of the fruits in the cart.
  UnmodifiableListView<Fruit> get fruits => UnmodifiableListView(_fruits);

  /// The current total price of all fruits (assuming all fruits cost $42).
  double get totalPrice => _fruits.fold<double>(
      0, (previousValue, element) => previousValue + element.price);

  /// Adds [Fruit]to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Fruit unFruit) {
    _fruits.add(unFruit);
    notifyListeners();
  }

  /// Removes all fruits from the cart.
  void removeAll() {
    _fruits.clear();
    notifyListeners();
  }

  /// Remove one fruit from the cart
  void removeOneFruit(Fruit unFruit) {
    _fruits.remove(unFruit);
    notifyListeners();
  }

  void setFruitDetail(Fruit unFruit) {
    _fruitDetail = unFruit;
  }

  getFruitDetail() {
    return _fruitDetail;
  }
}

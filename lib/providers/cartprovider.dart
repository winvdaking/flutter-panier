import 'package:flutter/material.dart';
import 'package:panier/class/fruit.dart';

class CartProvider extends ChangeNotifier {
  final List<Fruit> _fruits = [];

  List<Fruit> get fruits => _fruits;

  double get totalPrice => _fruits.fold<double>(
      0, (previousValue, element) => previousValue + element.price);

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

  String nbFruitInCart(Fruit unFruit) {
    int nb = 0;

    for (var fruit in _fruits) {
      if (fruit == unFruit) {
        nb++;
      }
    }

    return nb.toString();
  }

  List<int> getFruitsId() {
    List<int> ids = [];
    for (var fruit in _fruits) {
      ids.add(fruit.id);
    }
    return ids;
  }
}

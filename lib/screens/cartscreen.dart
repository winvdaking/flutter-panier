import 'package:flutter/material.dart';
import 'package:panier/class/fruit.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  CartProvider cart = CartProvider();

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Total panier : ${cart.totalPrice}€"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: cart.fruits.length,
          itemBuilder: (context, index) {
            Fruit currentFruit = cart.fruits[index];

            return ListTile(
                tileColor: currentFruit.color,
                title: Text(currentFruit.name),
                hoverColor: const Color.fromRGBO(0, 0, 0, .5),
                leading: Image.asset(currentFruit.url),
                trailing: const Icon(Icons.delete),
                onTap: () {
                  cart.removeOneFruit(currentFruit);
                  var msg = SnackBar(
                    content: Text(
                        "${currentFruit.name} vient d'être supprimé(e) du panier !"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(msg);
                });
          },
        ),
      ),
    );
  }
}

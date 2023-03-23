import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:panier/class/fruit.dart';
import 'package:panier/class/user.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:panier/providers/userprovider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  CartProvider cart = CartProvider();
  UserProvider user = UserProvider();

  void _commanderPanier() async {
    try {
      User? customer = user.currentUser;
      print(customer.toString());
      var response = await http.post(
        Uri.parse(
            'https://fruits.shrp.dev/auth/login?access_token=${user.getAccessToken()}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer ${user.getAccessToken()}"
        },
        body: jsonEncode(<String, dynamic>{
          "customer_id": customer!.id,
          "amount": cart.totalPrice,
          "fruits": cart.getFruitsId()
        }),
      );

      var resp = jsonDecode(utf8.decode(response.bodyBytes));
      print(resp);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    var user = context.watch<UserProvider>();
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
        actions: [
          IconButton(
              onPressed: () => _commanderPanier(),
              icon: const Icon(Icons.attach_money_rounded))
        ],
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

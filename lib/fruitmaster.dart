import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/fruitpreview.dart';
import 'package:panier/providers/cartprovider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class FruitMaster extends StatefulWidget {
  const FruitMaster({super.key, required this.title, required this.lesFruits});
  final String title;
  final List<Fruit> lesFruits;

  @override
  State<FruitMaster> createState() => _FruitMasterState();
}

class _FruitMasterState extends State<FruitMaster> {
  late CartProvider cart = CartProvider();
  final String _title = "Total panier : €";
  late Future<List<Fruit>> lesFruitsFuture = _fetchApi();

  Future<List<Fruit>> _fetchApi() async {
    final List<Fruit> fruits = [];
    final response =
        await http.get(Uri.parse('https://fruits.shrp.dev/items/fruits'));

    if (response.statusCode == 200) {
      for (var fruit in jsonDecode(response.body)['data']) {
        fruits.add(Fruit.fromJson(fruit));
      }
    } else {
      throw Exception('Failed to load fruits');
    }
    return fruits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/panier');
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: lesFruitsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final Fruit currentFruit = snapshot.data![index];
                      return Consumer<CartProvider>(
                        builder: (context, cart, child) {
                          return FruitPreview(unFruit: currentFruit);
                        },
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}

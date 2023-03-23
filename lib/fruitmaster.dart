import 'package:flutter/material.dart';
import 'package:panier/class/fruit.dart';
import 'package:panier/fruitpreview.dart';
import 'package:panier/providers/cartprovider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:panier/providers/userprovider.dart';
import 'package:provider/provider.dart';

class FruitMaster extends StatefulWidget {
  const FruitMaster({super.key, required this.title, required this.lesFruits});
  final String title;
  final List<Fruit> lesFruits;

  @override
  State<FruitMaster> createState() => _FruitMasterState();
}

class _FruitMasterState extends State<FruitMaster> {
  /// Providers
  late CartProvider cart = CartProvider();
  late UserProvider user = UserProvider();

  final String _title = "Flutter Panier";
  late Future<List<Fruit>> lesFruitsFuture = _fetchApi();
  late List<String> lesSaisons = ['Tous'];
  late String seasonSelected = lesSaisons[0];

  Future<List<Fruit>> _fetchApi() async {
    final List<Fruit> fruits = [];
    final response = await http
        .get(Uri.parse('https://fruits.shrp.dev/items/fruits?fields=*.*'));

    if (response.statusCode == 200) {
      for (var fruit in jsonDecode(response.body)['data']) {
        fruits.add(Fruit.fromJson(fruit));
      }

      for (var fruit in fruits) {
        if (!lesSaisons.contains(fruit.season)) {
          lesSaisons.add(fruit.season);
        }
      }
    } else {
      throw Exception('Failed to load fruits');
    }
    return fruits;
  }

  void fruitFiltreChanged(value) {
    setState(() {
      lesFruitsFuture = _fetchApi();
      if (value == 'Tous') {
        seasonSelected = lesSaisons[0];
      } else {
        seasonSelected = value;
        lesFruitsFuture.then((fruits) {
          for (var fruit in fruits) {
            if (fruit.season.toLowerCase() != value.toString().toLowerCase()) {
              fruits.remove(fruit);
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.account_circle_rounded),
            onPressed: () => Navigator.pushNamed(context, '/login')),
        actions: [
          user.isValid()
              ? Consumer<UserProvider>(
                  builder: (context, cart, child) {
                    return TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/logout');
                      },
                      child: Text(user.currentUser!.email),
                    );
                  },
                )
              : Container(),
          DropdownButton<String>(
              value: seasonSelected,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? value) {
                fruitFiltreChanged(value);
              },
              items: lesSaisons.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
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

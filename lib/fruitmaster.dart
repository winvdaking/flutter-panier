import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/fruitpreview.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:panier/screens/cartscreen.dart';
import 'package:panier/screens/fruitdetail.dart';

class FruitMaster extends StatefulWidget {
  const FruitMaster({super.key, required this.title, required this.lesFruits});
  final String title;
  final List<Fruit> lesFruits;

  @override
  State<FruitMaster> createState() => _FruitMasterState();
}

class _FruitMasterState extends State<FruitMaster> {
  late CartProvider cart = CartProvider();
  late String _title = "Total panier : ${cart.totalPrice}€";
  final PageController _pageController = PageController();
  late Future<List<Fruit>> lesFruitsFuture;
  late List<Fruit> lesFruits = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    lesFruitsFuture = fetchFruit();
  }

  void _fruitClickDetail(Fruit unF) {
    setState(() {
      cart.setFruitDetail(unF);
      _title = unF.name;
    });
  }

  // void _fruitClickRemovePanier(Fruit unF) {
  //   setState(() {
  //     if (fruitAuPanier.containsKey(unF.name)) {
  //       var qte = fruitAuPanier[unF.name][1];
  //       if (qte == 1) {
  //         fruitAuPanier.remove(unF.name);
  //       } else {
  //         fruitAuPanier.update(unF.name, (value) => [unF, qte - 1]);
  //       }

  //       _total = _total - unF.price;
  //       _title = "Total panier : $_total€";
  //       var msgSnackBar = SnackBar(
  //           content: Text("Vous venez de supprimer : ${unF.name} du panier."));

  //       ScaffoldMessenger.of(context).showSnackBar(msgSnackBar);
  //     }
  //   });
  // }

  // void _fruitClickPanier(Fruit unF) {
  //   setState(() {
  //     if (fruitAuPanier.containsKey(unF.name)) {
  //       var qte = fruitAuPanier[unF.name][1];
  //       fruitAuPanier.update(unF.name, (value) => [unF, qte + 1]);
  //     } else {
  //       fruitAuPanier[unF.name] = [unF, 1];
  //     }
  //     _total = _total + unF.price;
  //     _title = "Total panier : $_total€";
  //   });

  //   var msgSnackBar = SnackBar(
  //       content: Text("Vous venez d'ajouter : ${unF.name} au panier !"));

  //   ScaffoldMessenger.of(context).showSnackBar(msgSnackBar);
  // }

  final int _selectedIndex = 0;

  Future<List<Fruit>> fetchFruit() async {
    final response =
        await http.get(Uri.parse('https://fruits.shrp.dev/items/fruits'));

    if (response.statusCode == 200) {
      for (var fruit in jsonDecode(response.body)['data']) {
        lesFruits.add(Fruit.fromJson(fruit));
      }
      return lesFruits;
    } else {
      throw Exception('Failed to load fruits');
    }
  }

  List<Widget> _widgetOptions(data) {
    return [
      PageView(
        controller: _pageController,
        children: [
          Center(
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final Fruit currentFruit = data[index];
                  return FruitPreview(
                    unFruit: currentFruit,
                    onFruitClick: _fruitClickDetail,
                    pageController: _pageController,
                  );
                }),
          ),
          Center(child: FruitDetailsScreen(unFruit: cart.getFruitDetail())),
        ],
      ),
      CartScreen()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
        leading: const Visibility(
            visible: true, child: Icon(Icons.arrow_back_ios_new)),
        actions: const [
          Visibility(visible: true, child: Icon(Icons.shopping_cart))
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: lesFruitsFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return _widgetOptions(snapshot.data)[_selectedIndex];
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}

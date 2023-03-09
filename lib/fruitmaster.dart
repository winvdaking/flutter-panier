import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/fruitpreview.dart';
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
  double _total = 0;
  String _title = 'Total panier : 0€';
  final PageController _pageController = PageController();
  late List<Fruit> lesFruits;
  late List<Fruit> fruitAuPanier = [];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    lesFruits = widget.lesFruits;
    super.initState();
  }

  void _addFruit() {
    setState(() {
      lesFafficher.add(lesFruits[Random().nextInt(lesFruits.length)]);
    });
  }

  void _fruitClickDetail(Fruit unF) {
    setState(() {
      fruitDetail = unF;
      _title = unF.name;
    });
  }

  void _fruitClickRemovePanier(Fruit unF) {
    setState(() {
      if (fruitAuPanier.contains(unF)) {
        fruitAuPanier.remove(unF);
        _total = _total - unF.price;
        _title = "Total panier : $_total€";
        var msgSnackBar = SnackBar(
            content: Text("Vous venez de supprimer : ${unF.name} du panier."));

        ScaffoldMessenger.of(context).showSnackBar(msgSnackBar);
      }
    });
  }

  void _fruitClickPanier(Fruit unF) {
    setState(() {
      fruitAuPanier.add(unF);
      _total = _total + unF.price;
      _title = "Total panier : $_total€";
    });
    var msgSnackBar = SnackBar(
        content: Text("Vous venez d'ajouter : ${unF.name} au panier !"));

    ScaffoldMessenger.of(context).showSnackBar(msgSnackBar);
  }

  Fruit fruitDetail = Fruit('', 0, Colors.amber, '');
  List<Fruit> lesFafficher = [];
  late int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions() {
    return [
      PageView(
        controller: _pageController,
        children: [
          Center(
            child: ListView.builder(
                itemCount: lesFafficher.length,
                itemBuilder: (context, index) {
                  final Fruit currentFruit = lesFafficher[index];
                  return FruitPreview(
                    unFruit: currentFruit,
                    onFruitClick: _fruitClickDetail,
                    pageController: _pageController,
                  );
                }),
          ),
          Center(
              child: FruitDetailsScreen(
            fruit: fruitDetail,
            pageController: _pageController,
            addPanier: _fruitClickPanier,
          )),
        ],
      ),
      CartScreen(
          pageController: _pageController,
          lesFruitsDansLePanier: fruitAuPanier,
          removeFruitPanier: _fruitClickRemovePanier)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        centerTitle: true,
      ),
      body: _widgetOptions()[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Panier',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addFruit(),
        tooltip: 'Ajout d\'un fruit',
        child: const Icon(Icons.add),
      ),
    );
  }
}

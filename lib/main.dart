import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';
import 'package:panier/screens/fruitdetail.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final List<Fruit> fruits = [
    Fruit('Ananas', 2, Colors.orange, '../images/ananas.png'),
    Fruit('Banane', 0.94, Colors.yellow, '../images/banane.png'),
    Fruit('Cassis', 4, Colors.purple, '../images/cassis.png'),
    Fruit('Citron Vert', 2.49, Colors.green, '../images/citron-vert.png'),
    Fruit('Citron', 3.69, Colors.yellow, '../images/citron.png'),
    Fruit('Fraise', 1.78, Colors.red, '../images/fraise.png'),
    Fruit('Framboise', 1.82, Colors.purple, '../images/framboise.png'),
    Fruit('FRuit de la passion', 9.99, Colors.deepOrange,
        '../images/fruit-de-la-passion.png'),
    Fruit('Grenade', 1.13, Colors.red, '../images/grenade.png'),
    Fruit('Kaki', 5, Colors.brown, '../images/kaki.png'),
    Fruit('Kiwi', 2.50, Colors.green, '../images/kiwi.png'),
    Fruit('Litchi', 1.99, Colors.pink, '../images/litchi.png'),
    Fruit('Mangue', 4.99, Colors.deepOrange, '../images/mangue.png'),
    Fruit('Mure', 0.99, Colors.purple, '../images/mure.png'),
    Fruit('Myrtille', 3.99, Colors.pink, '../images/myrtille.png'),
    Fruit('Orange', 3, Colors.orange, '../images/orange.png'),
    Fruit('Pasteque', 7.33, Colors.lightGreen, '../images/pasteque.png'),
    Fruit('Peche', 2.09, Colors.orange, '../images/peche.png')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Panier',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FruitMaster(
        title: 'Total panier :',
        lesFruits: fruits,
      ),
    );
  }
}

class FruitMaster extends StatefulWidget {
  const FruitMaster({super.key, required this.title, required this.lesFruits});
  final String title;
  final List<Fruit> lesFruits;

  @override
  State<FruitMaster> createState() => _FruitMasterState();
}

class _FruitMasterState extends State<FruitMaster> {
  double _total = 0;
  final PageController _pageController = PageController();

  late List<Fruit> lesFruits;

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

  void _fruitClickAdd(Fruit unF) {
    setState(() {
      _total = _total + unF.price;
    });
  }

  List<Fruit> lesFafficher = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.title} $_total'),
          centerTitle: true,
        ),
        body: PageView(
          controller: _pageController,
          children: [
            Center(
              child: ListView.builder(
                  itemCount: lesFafficher.length,
                  itemBuilder: (context, index) {
                    final Fruit currentFruit = lesFafficher[index];
                    return FruitPreview(
                      unFruit: currentFruit,
                      onFruitClick: _fruitClickAdd,
                      pageController: _pageController,
                    );
                  }),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: const Text('Previous'),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addFruit(),
          tooltip: 'Ajout d\'un fruit',
          child: const Icon(Icons.add),
        ));
  }
}

class FruitPreview extends StatelessWidget {
  const FruitPreview(
      {super.key,
      required this.unFruit,
      required this.onFruitClick,
      required this.pageController});

  final Fruit unFruit;
  final Function onFruitClick;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: unFruit.color,
        title: Text(unFruit.name),
        hoverColor: const Color.fromRGBO(0, 0, 0, .5),
        leading: Image.asset(unFruit.url),
        onTap: () {
          if (pageController.hasClients) {
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          }
        });
  }
}

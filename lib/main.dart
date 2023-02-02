import 'package:flutter/material.dart';
import 'package:panier/fruit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  List<Fruit> fruits = [
    Fruit('Abricot', 2, Colors.orange),
    Fruit('Amande', 0.94, Colors.green),
    Fruit('Ananas', 4, Colors.green),
    Fruit('Avocat', 2.49, Colors.green),
    Fruit('Banane', 3.69, Colors.yellow),
    Fruit('Cassis', 1.78, Colors.pink),
    Fruit('Cerise', 0.82, Colors.purple),
    Fruit('Citron', 2, Colors.yellow),
    Fruit('Clémentine', 1.13, Colors.orange),
    Fruit('Datte', 5, Colors.brown),
    Fruit('Fraise', 2.50, Colors.red),
    Fruit('Framboise', 1.99, Colors.pink),
    Fruit('Fruit de la passion', 9.99, Colors.deepOrange),
    Fruit('Kiwi', 0.99, Colors.green),
    Fruit('Litchi', 3.99, Colors.pink)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Flutter Demo Home Page',
        fruits: fruits,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.fruits});
  final String title;
  final List<Fruit> fruits;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Clique',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

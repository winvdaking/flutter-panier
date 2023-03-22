import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:panier/class/fruit.dart';
import 'package:panier/providers/cartprovider.dart';
import 'package:panier/quantitybadge.dart';
import 'package:provider/provider.dart';

class FruitDetailsScreen extends StatelessWidget {
  FruitDetailsScreen({super.key, required this.unFruit});

  final CartProvider cart = CartProvider();
  final Fruit unFruit;

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(unFruit.name),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
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
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset(unFruit.url, height: 80, width: 80)),
            Padding(
                padding: const EdgeInsets.all(3), child: Text(unFruit.name)),
            Padding(
                padding: const EdgeInsets.all(3),
                child: Text("${unFruit.price}€")),
            Padding(
                padding: const EdgeInsets.all(3), child: Text(unFruit.season)),
            Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Quantité dans le panier : "),
                  Consumer<CartProvider>(
                    builder: (context, cart, child) {
                      return QuantityBadge(unFruit: unFruit);
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton(
                  onPressed: () {
                    cart.add(unFruit);
                    var msg = SnackBar(
                      content: Text(
                          "${unFruit.name} vient d'être ajouté(e) au panier !"),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(msg);
                  },
                  child: const Text('Ajouter ce fruit au panier')),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: SizedBox(
                height: 250,
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(unFruit.origin.location.coordinates[1],
                        unFruit.origin.location.coordinates[0]),
                    zoom: 9.2,
                  ),
                  nonRotatedChildren: [
                    AttributionWidget.defaultWidget(
                      source: 'OpenStreetMap contributors',
                      onSourceTapped: null,
                    ),
                  ],
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: unFruit.name,
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                            point: LatLng(
                                unFruit.origin.location.coordinates[1],
                                unFruit.origin.location.coordinates[0]),
                            builder: (BuildContext context) {
                              return const Icon(Icons.location_on);
                            })
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

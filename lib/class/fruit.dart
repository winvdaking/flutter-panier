import 'package:flutter/material.dart';
import 'package:panier/class/origin.dart';

class Fruit {
  final int id;
  final String name;
  final num price;
  final Color color;
  final String url;
  final int quantiteStock;
  final String season;
  final Origin origin;

  Fruit({
    required this.id,
    required this.name,
    required this.price,
    required this.color,
    required this.url,
    required this.quantiteStock,
    required this.season,
    required this.origin,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
        id: json['id'],
        name: json['name'],
        color: Color(_getColorFromHex(json['color'])),
        quantiteStock: json['stock'],
        url: "../images/${json['image']}",
        price: json['price'],
        season: json['season'],
        origin: Origin(
            id: json['origin']['id'],
            name: json['origin']['name'],
            location: Location(
                type: json['origin']['location']['type'],
                coordinates: json['origin']['location']['coordinates'])));
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
}

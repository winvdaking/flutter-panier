import 'package:flutter/material.dart';

class Fruit {
  final int id;
  final String name;
  final num price;
  final Color color;
  final String url;
  final int quantiteStock;
  final String season;

  Fruit(
      {required this.id,
      required this.name,
      required this.price,
      required this.color,
      required this.url,
      required this.quantiteStock,
      required this.season});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
        id: json['id'],
        name: json['name'],
        color: Color(_getColorFromHex(json['color'])),
        quantiteStock: json['stock'],
        url: "../images/${json['image']}",
        price: json['price'],
        season: json['season']);
  }

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
}

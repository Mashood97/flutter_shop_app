import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fluttershopapp/models/http_exception.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavourite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.imageUrl,
      @required this.price,
      this.isFavourite = false});

  void _setFavValue(bool newVal) {
    isFavourite = newVal;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();

    final url =
        'https://flutter-firebase-shop-app.firebaseio.com/products/$id.json?auth=$token';
    try {
      final response = await http.patch(url,
          body: json.encode({
            'isFavorite': isFavourite,
          }));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}

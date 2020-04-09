import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttershopapp/provider/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _items = [];

  final authToken;
  final String userId;
  Orders(this.authToken,this.userId,this._items);

  List<OrderItem> get items {
    return [..._items];
  }

  Future<void> getandSetOrders() async {
    final url = 'https://flutter-firebase-shop-app.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    print(json.decode(response.body));
    final ExtractedData = json.decode(response.body) as Map<String, dynamic>;
    if (ExtractedData == null) {
      return;
    }
    List<OrderItem> loadedorders = [];
    ExtractedData.forEach((orderId, orderData) {
      loadedorders.add(
        (OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>).map((cartItem) {
            return CartItem(
              id: cartItem['id'],
              price: cartItem['price'],
              title: cartItem['title'],
              quantity: cartItem['quantity'],
            );
          }).toList(),
        )),
      );
    });
    _items = loadedorders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> productsCart, double amt) async {
    final url = 'https://flutter-firebase-shop-app.firebaseio.com/orders/$userId.json?auth=$authToken';
    final datetime = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': amt,
          'dateTime': datetime.toIso8601String(),
          'products': productsCart
              .map((cartProd) => {
                    'id': cartProd.id,
                    'title': cartProd.title,
                    'quantity': cartProd.quantity,
                    'price': cartProd.price,
                  })
              .toList(),
        },
      ),
    );

    _items.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          amount: amt,
          products: productsCart,
          dateTime: datetime),
    );
    notifyListeners();
  }
}

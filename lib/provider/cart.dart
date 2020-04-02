import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get getItemCount {
    return _items.length;
  }

  void removeItem(String prodid) {
    _items.remove(prodid);
    notifyListeners();
  }

  double get totalPrice {
    double totalAmt = 0.0;
    _items.forEach((key, cart) {
      totalAmt += cart.price * cart.quantity;
    });
    return totalAmt;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingvalue) => CartItem(
                id: existingvalue.id,
                price: existingvalue.price,
                title: existingvalue.title,
                quantity: existingvalue.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toIso8601String(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity - 1,
        ),
      );
    }
    else
      {
        _items.remove(productId);
      }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}

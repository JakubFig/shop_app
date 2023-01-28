import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int qunatity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.qunatity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.qunatity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      //change quantity...
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              qunatity: existingCartItem.qunatity + 1,
              price: existingCartItem.price));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          qunatity: 1,
        ),
      );
    }
    notifyListeners();
  }
}

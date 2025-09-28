import 'package:flutter/material.dart';
import 'package:storeapp/model/product_model.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cart => _cart;

  void addToCart(Product product) {
    if (!_cart.contains(product)) {
      _cart.add(product);
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  bool isInCart(Product product) {
    return _cart.contains(product);
  }
}

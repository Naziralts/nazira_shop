import 'package:hive/hive.dart';

class CartService {
  // Singleton pattern
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  // Hive box’ту колдонууда гана ачат
  Box get _cartBox => Hive.box('cart');

  // Cart методдору
  void addToCart(String productId) {
    final existing = _cartBox.get(productId);
    if (existing != null) {
      _cartBox.put(productId, {'productId': productId, 'quantity': existing['quantity'] + 1});
    } else {
      _cartBox.put(productId, {'productId': productId, 'quantity': 1});
    }
  }

  void removeFromCart(String productId) => _cartBox.delete(productId);

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productId);
    } else {
      _cartBox.put(productId, {'productId': productId, 'quantity': quantity});
    }
  }

  List<Map<String, dynamic>> getCartItems() {
    return _cartBox.values.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  double getTotalPrice(Map<String, double> prices) {
    double total = 0;
    for (var item in getCartItems()) {
      final price = prices[item['productId']] ?? 0;
      total += price * (item['quantity'] ?? 1);
    }
    return total;
  }
}

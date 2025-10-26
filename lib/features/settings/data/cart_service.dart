import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final String _cartKey = 'cart_items';

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_cartKey);
    if (jsonString == null) return [];
    return List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  }

  Future<void> addToCart(String productId, double price) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await getCartItems();
    final existing = cart.indexWhere((item) => item['productId'] == productId);

    if (existing != -1) {
      cart[existing]['quantity']++;
    } else {
      cart.add({'productId': productId, 'price': price, 'quantity': 1});
    }

    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  Future<void> removeFromCart(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await getCartItems();
    cart.removeWhere((item) => item['productId'] == productId);
    await prefs.setString(_cartKey, jsonEncode(cart));
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final prefs = await SharedPreferences.getInstance();
    final cart = await getCartItems();
    final index = cart.indexWhere((item) => item['productId'] == productId);
    if (index != -1) {
      cart[index]['quantity'] = quantity;
      await prefs.setString(_cartKey, jsonEncode(cart));
    }
  }

  double getTotalPrice(Map<String, double> prices, List<Map<String, dynamic>> cart) {
    double total = 0;
    for (var item in cart) {
      total += (prices[item['productId']] ?? 0) * item['quantity'];
    }
    return total;
  }
}

import 'package:hive/hive.dart';
import '../../../core/constants/hive_boxes.dart';

class CartItem {
  final int productId;
  int quantity;
  CartItem({required this.productId, this.quantity = 1});
}

class CartService {
  final Box _box = Hive.box(HiveBoxes.cartBox);

  List<CartItem> getCartItems() => _box.values
      .map((e) => CartItem(productId: e['productId'], quantity: e['quantity']))
      .toList();

  void addToCart(int productId) {
    if (_box.containsKey(productId)) {
      final item = _box.get(productId);
      item['quantity'] += 1;
      _box.put(productId, item);
    } else {
      _box.put(productId, {'productId': productId, 'quantity': 1});
    }
  }

  void removeFromCart(int productId) => _box.delete(productId);

  void updateQuantity(int productId, int quantity) =>
      _box.put(productId, {'productId': productId, 'quantity': quantity});

  double getTotalPrice(Map<int, double> productPrices) {
    double total = 0;
    for (var item in getCartItems()) {
      final price = productPrices[item.productId] ?? 0;
      total += price * item.quantity;
    }
    return total;
  }
}

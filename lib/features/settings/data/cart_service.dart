class CartItem {
  final String productId;
  int quantity;

  CartItem({
    required this.productId,
    this.quantity = 1,
  });
}

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItem> _cartItems = [];

  List<CartItem> getCartItems() => _cartItems;

  void addToCart(String productId) {
    final existing = _cartItems.where((item) => item.productId == productId);
    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      _cartItems.add(CartItem(productId: productId));
    }
  }

  void updateQuantity(String productId, int quantity) {
    for (var item in _cartItems) {
      if (item.productId == productId) {
        item.quantity = quantity;
        break;
      }
    }
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
  }

  void clearCart() {
    _cartItems.clear();
  }

  double getTotalPrice(Map<String, double> prices) {
    double total = 0;
    for (var item in _cartItems) {
      total += (prices[item.productId] ?? 0) * item.quantity;
    }
    return total;
  }
}

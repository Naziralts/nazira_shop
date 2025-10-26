import 'package:flutter/material.dart';
import 'package:nazira_shop/features/settings/data/cart_service.dart';

import '../../../products/data/products_repository.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = CartService(); // Singleton instance
    final repository = ProductsRepository();
    final cartItems = cartService.getCartItems();

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          final product = repository.getProductById(item['productId'])!;
          return ListTile(
            leading: Image.network(product.image),
            title: Text(product.title),
            subtitle: Text('Quantity: ${item['quantity']} - \$${product.price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    cartService.updateQuantity(product.id, (item['quantity'] ?? 1) - 1);
                    (context as Element).reassemble();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    cartService.updateQuantity(product.id, (item['quantity'] ?? 1) + 1);
                    (context as Element).reassemble();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    cartService.removeFromCart(product.id);
                    (context as Element).reassemble();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension on Future<List<Map<String, dynamic>>> {
  int? get length => null;

  operator [](int other) {}
}

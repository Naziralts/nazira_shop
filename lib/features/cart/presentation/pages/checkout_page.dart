import 'package:flutter/material.dart';

import 'package:nazira_shop/features/settings/data/cart_service.dart';

import '../../../products/data/products_repository.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = CartService();
    final repository = ProductsRepository();
    final cartItems = cartService.getCartItems();

    double total = cartService.getTotalPrice({
      for (var product in repository.getAllProducts()) product.id: product.price
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Total: \$${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Pay with Stripe (Test)'),
              onPressed: () async {
                // Mock payment, no real transaction
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment Success (Test)')),
                );
                cartService.getCartItems().forEach((item) => cartService.removeFromCart(item.productId));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

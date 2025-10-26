import 'package:flutter/material.dart';
import 'package:nazira_shop/features/settings/data/cart_service.dart';
import '../../../products/data/products_repository.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartService = CartService(); // Singleton instance
    final repository = ProductsRepository();
    final cartItems = cartService.getCartItems();

    // productPrices map түзүү
    final productPrices = {
      for (var product in repository.getAllProducts()) product.id: product.price
    };

    // total сумманы эсептөө
    double total = cartService.getTotalPrice(productPrices, cartItems as List<Map<String, dynamic>>); // Assuming cartItems is the second argument

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: \$${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Pay with Stripe (Test)'),
              onPressed: () async {
                // Mock payment, real transaction жок
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment Success (Test)')),
                );

                // Cart тазалоо
                for (var item in await cartItems) {
                  final productId = item['productId'] as String?;
                  if (productId != null) {
                    cartService.removeFromCart(productId);
                  }
                }

                Navigator.pop(context); // Checkout page жабуу
              },
            ),
          ],
        ),
      ),
    );
  }
}

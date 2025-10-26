import 'package:flutter/material.dart';
import 'package:nazira_shop/features/products/data/models/product_model.dart';

import 'package:nazira_shop/features/products/data/products_repository.dart';
import 'package:nazira_shop/features/products/presentation/pages/product_details_page.dart';

import 'package:nazira_shop/features/settings/data/cart_service.dart';
import 'package:nazira_shop/features/settings/data/favorites/data/favorites_service.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ProductsRepository _repository = ProductsRepository();
  final FavoritesService _favoritesService = FavoritesService();
  final CartService _cartService = CartService();

  late List<ProductModel> _products;
  
  double? get quantity => null;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _products = _repository.getAllProducts();
  }

  void _toggleFavorite(String productId) {
    _favoritesService.toggleFavorite(productId as String);
    setState(() {});
  }

  void _addToCart(String productId) {
    _cartService.addToCart(productId, quantity!); // Assuming 'quantity' is defined elsewhere
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart')),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final favoriteIds = _favoritesService.getFavorites();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: _products.isEmpty
          ? const Center(child: Text('No products available'))
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                final isFav = favoriteIds.contains(product.id);

                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      // Open product details (pass whole model)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsPage(product: product),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // image
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                              errorBuilder: (c, e, st) => const Icon(Icons.broken_image),
                              loadingBuilder: (c, child, progress) {
                                if (progress == null) return child;
                                return const Center(child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),

                        // info
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 6),
                              Text('\$${product.price.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 14, color: Colors.green)),
                              const SizedBox(height: 8),

                              // actions row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border,
                                        color: isFav ? Colors.red : Colors.grey),
                                    onPressed: () => _toggleFavorite(product.id),
                                  ),
                                  ElevatedButton(
                                    onPressed: () => _addToCart(product.id),
                                    child: const Text('Add'),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

extension on Future<List<String>> {
  contains(String id) {}
}

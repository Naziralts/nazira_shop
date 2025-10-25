import 'package:flutter/material.dart';
import 'package:nazira_shop/features/products/data/products_repository.dart';
import '../../data/favorites_service.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final favoritesService = FavoritesService();
  final repository = ProductsRepository();

  @override
  Widget build(BuildContext context) {
    final favoriteIds = favoritesService.getFavorites();
    final favoriteProducts = favoriteIds
        .map((id) => repository.getProductById(id as String))
        .where((product) => product != null)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites ❤️')),
      body: favoriteProducts.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index]!;

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        favoritesService.toggleFavorite(product.id as int);
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}

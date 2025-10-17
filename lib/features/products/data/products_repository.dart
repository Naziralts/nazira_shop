import 'models/product_model.dart';

class ProductsRepository {
  // Mock data for portfolio
  final List<Product> _products = [
    Product(
      id: 1,
      title: 'Smartphone',
      description: 'High quality smartphone',
      image: 'https://via.placeholder.com/150',
      price: 299.99,
    ),
    Product(
      id: 2,
      title: 'Laptop',
      description: 'Powerful laptop',
      image: 'https://via.placeholder.com/150',
      price: 799.99,
    ),
    Product(
      id: 3,
      title: 'Headphones',
      description: 'Noise cancelling',
      image: 'https://via.placeholder.com/150',
      price: 99.99,
    ),
  ];

  List<Product> getAllProducts() => _products;

  Product getProductById(int id) =>
      _products.firstWhere((product) => product.id == id);
}

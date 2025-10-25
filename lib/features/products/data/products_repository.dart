import 'package:nazira_shop/features/products/data/models/product_model.dart';



class ProductsRepository {
  final List<ProductModel> _products = [
    ProductModel(
      id: '1',
      title: 'T-Shirt',
      price: 20.0,
      image: 'https://cdn-icons-png.flaticon.com/512/892/892458.png',
    ),
    ProductModel(
      id: '2',
      title: 'Shoes',
      price: 50.0,
      image: 'https://cdn-icons-png.flaticon.com/512/809/809957.png',
    ),
    ProductModel(
      id: '3',
      title: 'Bag',
      price: 35.0,
      image: 'https://cdn-icons-png.flaticon.com/512/891/891462.png',
    ),
  ];

  List<ProductModel> getAllProducts() => _products;

  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  Future getProducts() async {}
}

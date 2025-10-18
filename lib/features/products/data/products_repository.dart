import 'package:dio/dio.dart';
import 'package:nazira_shop/features/products/data/models/product_model.dart';


class ProductsRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com/'));

  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get('/products');
    final data = response.data as List;
    return data.map((json) => ProductModel.fromJson(json)).toList();
  }
}

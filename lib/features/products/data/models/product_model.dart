class ProductModel {
  final String id;
  final String title;
  final double price;
  final String image;
  final String? description;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.description,
  });
}

part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;

  ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);

  @override
  List<Object?> get props => [message];
}

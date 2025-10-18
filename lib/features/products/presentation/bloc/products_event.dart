part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {}

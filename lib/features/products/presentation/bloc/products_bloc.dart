import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/product_model.dart';
import '../../data/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository repository;

  ProductsBloc(this.repository) : super(ProductsInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        final products = await repository.getProducts();
        emit(ProductsLoaded(products));
      } catch (e) {
        emit(ProductsError('Failed to load products'));
      }
    });
  }
}

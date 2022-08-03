import 'package:bakersofttest/services/data_service.dart';
import 'package:bakersofttest/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'product_details_state.dart';

part 'product_details_event.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {

  ProductDetailsBloc() : super(LoadingState()) {
    on<LoadEvent>((event, emit) async {

      print("productdetzils list_products_bloc");
      emit(DetailsLoadedState(product: event.product, price: event.product.price));
    });
    on<AddProductEvent>((event, emit) async {
      final state = this.state as DetailsLoadedState;
      double price = state.price + state.product.price;
      int nbProducts = state.nbProducts + 1;
      print("inside list_products_bloc");
      emit(
          DetailsLoadedState(product: state.product, price: price, nbProducts: nbProducts));
    });
    on<RemoveProductEvent>((event, emit) async {
      final state = this.state as DetailsLoadedState;
      if (state.nbProducts > 1) {
        double price = state.price - state.product.price;
        int nbProducts = state.nbProducts - 1;
        emit(DetailsLoadedState(
            product: state.product, price: price, nbProducts: nbProducts));
      }
    });
  }
}

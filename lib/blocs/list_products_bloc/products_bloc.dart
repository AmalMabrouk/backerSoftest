
import 'package:bakersofttest/services/data_service.dart';
import 'package:bakersofttest/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

part 'products_event.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  DataService dataService = DataService();
  ProductsBloc() : super(LoadingState()) {
    on<ProductsEvent>((event, emit) async {
      List<Product> products = await dataService.getProducts();
      emit(LoadedState(products:products));
    });
  }
}

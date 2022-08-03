import 'package:bakersofttest/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shopping_state.dart';

part 'shopping_event.dart';

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc() : super(LoadingState()) {
    on<LoadShoppingEvent>((event, emit) async {
      emit(ShoppingLoadedState(products: const {}));
    });
    on<AddToCartEvent>((event, emit) async {
      if (state is ShoppingLoadedState) {
        final state = this.state as ShoppingLoadedState;
        Map<Product, int> map = Map.from(state.products);
        map.containsKey(event.product)
            ? map.update(event.product, (value) => value + event.nbProduct)
            : map.putIfAbsent(event.product, () => event.nbProduct);
        emit(ShoppingLoadedState(products: map));
      }
    });
    on<RemoveFromCartEvent>((event, emit) async {
      if (state is ShoppingLoadedState) {
        final state = this.state as ShoppingLoadedState;
        Map<Product, int> map = Map.from(state.products);
        map.remove(event.product);
        emit(ShoppingLoadedState(products: map));
      }
    });
  }
}

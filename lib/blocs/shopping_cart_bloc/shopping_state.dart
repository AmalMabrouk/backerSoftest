part of 'shopping_bloc.dart';

@immutable
abstract class ShoppingState {}

class ProductsInitial extends ShoppingState {}

class LoadingState extends ShoppingState {}

class ShoppingLoadedState extends ShoppingState {
  Map<Product, int> products = {};

  ShoppingLoadedState({required this.products});

  int nbElementInCart() {
    int sum = products.values
        .toList()
        .fold<int>(0, (int sum, int item) => sum + item);
    return sum;
  }
}

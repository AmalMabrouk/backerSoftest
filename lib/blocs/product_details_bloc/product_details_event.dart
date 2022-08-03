part of 'product_details_bloc.dart';

@immutable
abstract class ProductDetailsEvent {}

class LoadEvent extends ProductDetailsEvent {
  Product product;
  LoadEvent({required this.product});
}

class AddProductEvent extends ProductDetailsEvent {

  AddProductEvent();
}

class RemoveProductEvent extends ProductDetailsEvent {
  RemoveProductEvent();
}

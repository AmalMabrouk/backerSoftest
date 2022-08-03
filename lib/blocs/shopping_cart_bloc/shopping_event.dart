part of 'shopping_bloc.dart';



@immutable
abstract class ShoppingEvent{}
class LoadShoppingEvent extends ShoppingEvent{}
class AddToCartEvent extends ShoppingEvent {

  Product product;
  int nbProduct;
  AddToCartEvent({required this.product,required this.nbProduct});
}

class RemoveFromCartEvent extends ShoppingEvent {
  Product product;
  RemoveFromCartEvent({required this.product,});}
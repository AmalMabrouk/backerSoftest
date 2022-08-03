part of 'favorite_bloc.dart';



@immutable
abstract class FavoriteEvent{}
class LoadFavoriteEvent extends FavoriteEvent{}
class AddToFavoriteEvent extends FavoriteEvent {

  Product product;
  AddToFavoriteEvent({required this.product});
}

class RemoveFromFavoriteEvent extends FavoriteEvent {
  Product product;
  RemoveFromFavoriteEvent({required this.product,});}
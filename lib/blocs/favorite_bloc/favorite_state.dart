part of 'favorite_bloc.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class LoadingState extends FavoriteState {}

class FavoriteLoadedState extends FavoriteState {
List<Product> favoriteList;
  FavoriteLoadedState({required this.favoriteList});


}

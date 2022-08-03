import 'package:bakersofttest/services/data_service.dart';
import 'package:bakersofttest/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'favorite_state.dart';

part 'favorite_event.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(LoadingState()) {
    on<LoadFavoriteEvent>((event, emit) async {
      emit(FavoriteLoadedState(favoriteList: List.empty(growable: true)));
    });
    on<AddToFavoriteEvent>((event, emit) async {

      if (state is FavoriteLoadedState) {
        final state = this.state as FavoriteLoadedState;
        emit(FavoriteLoadedState(
            favoriteList: List.from(state.favoriteList)..add(event.product)));
      }
    });
    on<RemoveFromFavoriteEvent>((event, emit) async {
      if (state is FavoriteLoadedState) {
        final state = this.state as FavoriteLoadedState;

        emit(FavoriteLoadedState(
            favoriteList: List.from(state.favoriteList)
              ..remove(event.product)));
      }
    });
  }
}

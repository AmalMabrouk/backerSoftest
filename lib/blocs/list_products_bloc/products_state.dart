
part of 'products_bloc.dart';


@immutable
abstract class ProductsState{}
class ProductsInitial extends ProductsState{}

class LoadingState extends ProductsState{}

class LoadedState extends ProductsState{
  List<Product> products = List.empty(growable: true);
  LoadedState({required this.products});
}

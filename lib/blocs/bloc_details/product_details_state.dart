part of 'product_details_bloc.dart';

@immutable
abstract class ProductDetailsState {}

class ProductsInitial extends ProductDetailsState {}

class  LoadingState extends ProductDetailsState {}

class DetailsLoadedState extends ProductDetailsState {
  Product product;
  int nbProducts ;
  double price;
  DetailsLoadedState({required this.product,this.nbProducts=1,this.price=0});
}

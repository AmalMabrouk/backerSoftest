
import 'package:bakersofttest/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:bakersofttest/blocs/list_products_bloc/products_bloc.dart';
import 'package:bakersofttest/models/product.dart';
import 'package:bakersofttest/views/favorite_list_view.dart';
import 'package:bakersofttest/views/product_details_view.dart';
import 'package:bakersofttest/widgets/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductsBloc()..add(LoadEvent())),
      ],
      child: Scaffold(
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                color: Colors.grey.withOpacity(0.4),
                height: 1,
              ),
            ),
            leading: const BackButton(color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: const <Widget>[ShoppingCart()],
            centerTitle: true,
            title: const Text("Brotchen"),
            titleTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          body: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
            if (state is LoadedState) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, right: 8, left: 8),
                child: GridView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    Product product = state.products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailsView(
                                    product: state.products.elementAt(index),
                                  )),
                        );
                      },
                      child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        )),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(8)),
                                        child: Image.network(
                                          product.imageUrl,
                                          fit: BoxFit.fill,
                                        ))),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${product.name}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${product.price}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 4, top: 4),
                              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                                  builder: (context, state) {
                                if (state is FavoriteLoadedState) {
                                  return state.favoriteList.contains(product)
                                      ? IconButton(
                                          onPressed: () {
                                            print("on press");
                                            context.read<FavoriteBloc>().add(
                                                RemoveFromFavoriteEvent(
                                                    product: product));
                                          },
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.green,
                                            size: 24,
                                          ),
                                        )
                                      : IconButton(
                                          onPressed: () {
                                            print("on press");

                                            context.read<FavoriteBloc>().add(
                                                AddToFavoriteEvent(
                                                    product: product));
                                          },
                                          icon: const Icon(
                                            Icons.favorite_border,
                                            color: Colors.green,
                                            size: 24,
                                          ),
                                        );
                                }
                                return Container();
                              }),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 8),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }),
          floatingActionButton: FloatingActionButton(
              elevation: 0.0,
              backgroundColor: const Color(0xFFE57373),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FavoriteListView()),
                );
              },
              child: Icon(Icons.favorite))),
    );
  }
}

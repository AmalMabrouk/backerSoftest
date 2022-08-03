import 'package:bakersofttest/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:bakersofttest/blocs/shopping_cart_bloc/shopping_bloc.dart';
import 'package:bakersofttest/models/product.dart';
import 'package:bakersofttest/widgets/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailsView extends StatelessWidget {
  final Product product;

  const DetailsView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                ProductDetailsBloc()..add(LoadEvent(product: product))),
      ],
      child: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
        if (state is DetailsLoadedState) {
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
              actions: const <Widget>[

                ShoppingCart()

              ],
              centerTitle: true,
              title: Text(state.product.name),
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  product.imageUrl,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 26,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "${product.name}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${state.price}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<ProductDetailsBloc>()
                                        .add(RemoveProductEvent());
                                  },
                                  icon: const Icon(
                                    Icons.indeterminate_check_box,
                                    color: Colors.black,
                                  )),
                              Text(state.nbProducts.toString()),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<ProductDetailsBloc>()
                                        .add(AddProductEvent());
                                  },
                                  icon: const Icon(
                                    Icons.add_box,
                                    color: Colors.black,
                                  )),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(color: Colors.grey),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF7a0012),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        //   fixedSize: const Size(300, 100),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      context.read<ShoppingBloc>().add(AddToCartEvent(
                          product: product, nbProduct: state.nbProducts));

                      // Respond to button press
                    },
                    child: Text('Add to the cart'),
                  ),
                )
              ],
            ),
          );
        }
        return Container(
          color: Colors.green,
        );
      }),
    );
  }
}

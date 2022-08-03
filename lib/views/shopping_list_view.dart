import 'package:bakersofttest/blocs/shopping_cart_bloc/shopping_bloc.dart';
import 'package:bakersofttest/models/product.dart';
import 'package:bakersofttest/views/product_details_view.dart';
import 'package:bakersofttest/widgets/shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingBloc, ShoppingState>(builder: (context, state) {
      if (state is ShoppingLoadedState) {
        return Scaffold(
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
              actions: const <Widget>[
                IgnorePointer(
                    ignoring: true, // or false
                    child: ShoppingCart())
              ],
              centerTitle: true,
              title: const Text("Basket"),
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            body: state.products.isEmpty
                ? const Center(child: Text("No Item"))
                : ListView.separated(
                    itemCount: state.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = state.products.keys.elementAt(index);

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsView(
                                        product: product,
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                    top: Radius.circular(8)),
                                            child: Image.asset(
                                              "assets/images/${product.imageUrl}",
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Center(
                                              child: Column(
                                            children: [
                                              Text(product.name,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14)),
                                              Text(product.price.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14))
                                            ],
                                          ))),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8, horizontal: 28),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      const Color(0xFF7a0012)),
                                            ),
                                            child: Text(state.products[product]
                                                .toString()),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    const Color(0xFF7a0012),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                //   fixedSize: const Size(300, 100),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10))),
                                            onPressed: () {
                                              context
                                                  .read<ShoppingBloc>()
                                                  .add(RemoveFromCartEvent(
                                                    product: product,
                                                  ));

                                              // Respond to button press
                                            },
                                            child: Text('Delete'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 20,
                      );
                    },
                  ));
      }
      return Container(
        color: Colors.white,
      );
    });
  }
}

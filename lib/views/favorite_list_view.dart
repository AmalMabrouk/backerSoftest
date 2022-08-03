import 'package:bakersofttest/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:bakersofttest/models/product.dart';
import 'package:bakersofttest/views/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(builder: (context, state) {
      if (state is FavoriteLoadedState) {
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
              centerTitle: true,
              title: const Text("Favorite"),
              titleTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            body: state.favoriteList.isEmpty
                ? const Center(child: Text("No Item"))
                : ListView.separated(
                    itemCount: state.favoriteList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Product product = state.favoriteList.elementAt(index);

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
                              child: Row(
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
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                          Text(product.price.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14))
                                        ],
                                      ))),
                                  Center(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFF7a0012),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          //   fixedSize: const Size(300, 100),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      onPressed: () {
                                        context
                                            .read<FavoriteBloc>()
                                            .add(RemoveFromFavoriteEvent(
                                              product: product,
                                            ));

                                        // Respond to button press
                                      },
                                      child: Text('Delete'),
                                    ),
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

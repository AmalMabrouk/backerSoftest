import 'package:bakersofttest/blocs/shopping_cart_bloc/shopping_bloc.dart';
import 'package:bakersofttest/views/shopping_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingBloc, ShoppingState>(builder: (context, state) {
      if (state is ShoppingLoadedState) {
        return GestureDetector(
          onTap: (){ Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ShoppingListView()),
          );},
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.shopping_cart,
                  size: 28.0,
                  color: Colors.black,
                ),
              ),
              Positioned(
                top: 7,
                right: 10,
                child: Container(
                  height: 22,
                  width: 22,
                  decoration:
                      const BoxDecoration(color:  Color(0xFF7a0012), shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      "${state.nbElementInCart()}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      return Container(
        color: Colors.white,
      );
    });
  }
}

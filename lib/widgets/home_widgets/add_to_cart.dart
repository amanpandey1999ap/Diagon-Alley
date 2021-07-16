import 'package:diagon_alley/core/store.dart';
import 'package:diagon_alley/models/cart.dart';
import 'package:diagon_alley/models/catalog.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddToCart extends StatelessWidget{
  final Item catalog;

  const AddToCart({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddMutation, RemoveMutation]);

    final CartModel _cart = (VxState.store as MyStore).cart;
    bool isInCart = _cart.items.contains(catalog);
    return ElevatedButton(
        onPressed: () {
          if(!isInCart) {
            AddMutation(catalog);
          }
        },
        style: ButtonStyle(
          //backgroundColor: MaterialStateProperty.all(MyTheme.darkBluishColor),
            shape: MaterialStateProperty.all(StadiumBorder())
        ),
        child: isInCart ? Icon(Icons.done_sharp) : 'Add to cart'.text.make());
  }
}
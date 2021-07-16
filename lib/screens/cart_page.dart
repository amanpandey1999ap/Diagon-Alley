import 'package:diagon_alley/core/store.dart';
import 'package:diagon_alley/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(title: "Cart".text.make().pOnly(left: 90.0),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(onTap: (){Navigator.pop(context);},
          child: Icon(Icons.arrow_back_ios_sharp),),
      ),

      body: Column(
        children: [
          _CartList().p32().expand(),
          Divider(),
          _CartTotal()

        ],
      ),

    );
  }
}

class _CartTotal extends StatelessWidget {
  //const _CartTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CartModel _cart = (VxState.store as MyStore).cart;
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          VxBuilder(
              builder: (context, store, status) => "\$${_cart.totalPrice}".text.xl3.color(context.theme.accentColor).make(),
              mutations: {RemoveMutation},
          ),
          30.widthBox,
          ElevatedButton(onPressed: (){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: 'This feature is under development'.text.make()));
          },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(StadiumBorder()),
                  backgroundColor: MaterialStateProperty.all(context.theme.buttonColor)),
              child: 'Buy'.text.color(context.cardColor).make()).wh(120, 40)
        ],
      ),
    );
  }
}

class _CartList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [RemoveMutation]);
    final CartModel _cart = (VxState.store as MyStore).cart;
    return  _cart.items.isEmpty ? "Your Cart is Empty".text.xl2.makeCentered() : ListView.builder(
        itemCount: _cart.items.length,
        itemBuilder: (context,index) => ListTile(
          leading: Icon(Icons.done_rounded),
          trailing: IconButton(
            icon: Icon(Icons.remove_circle_outline_rounded),
            onPressed: () => RemoveMutation(_cart.items[index]),
          ),
          title: _cart.items[index].name.text.make(),
        ),
    );
  }
}



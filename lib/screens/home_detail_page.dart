import 'package:diagon_alley/models/catalog.dart';
import 'package:diagon_alley/widgets/home_widgets/add_to_cart.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        leading: InkWell(onTap: (){ Navigator.pop(context);},child: Icon(Icons.arrow_back_ios_sharp)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        color: context.cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$${catalog.price}".text.bold.xl2.red900.make(),
            AddToCart(catalog: catalog).wh(120, 40)
          ],
        ).p32(),
      ),

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
                tag: Key(catalog.id.toString()),
                child: Image.network(catalog.image)).h40(context),
            Expanded(child: VxArc(
            height: 15.0,
            edge: VxEdge.TOP,
            arcType: VxArcType.CONVEY,
            child: Container(
              width: context.screenWidth,
            color: context.cardColor,
              child: Column(
                children: [
                  catalog.name.text.xl3.color(context.accentColor).bold.make(),
                  catalog.desc.text.lg.make(),
                  "A14 Bionic rockets past every other smartphone chip. The Pro camera system takes low-light photography to the next level — with an even bigger jump on iPhone 12 Pro Max.".text.make().p20()
                ],
              ).py32()),

                )
              ),
          ],
        ),
      ),
    );
  }
}

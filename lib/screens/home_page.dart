import 'package:diagon_alley/core/store.dart';
import 'package:diagon_alley/models/cart.dart';
import 'package:diagon_alley/models/catalog.dart';
import 'package:diagon_alley/utils/routes.dart';
import 'package:diagon_alley/widgets/drawer.dart';
import 'package:diagon_alley/widgets/home_widgets/catalog_header.dart';
import 'package:diagon_alley/widgets/home_widgets/catalog_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final url = "https://api.jsonbin.io/b/60f09d9ba917050205c8414f/1";

  @override
  void initState(){
    super.initState();
    loadData();
  }

  loadData() async {

    //await Future.delayed(Duration(seconds: 5));

    //load from file
    final catalogJson = await rootBundle.loadString("assets/files/catalog.json");

    //load from API
    // final response = await http.get(Uri.parse(url));
    // final catalogJson = response.body;


    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];
    CatalogModel.items = List.from(productsData).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    final _cart = (VxState.store as MyStore).cart;
    return Scaffold(
      backgroundColor: context.canvasColor,
      drawer: MyDrawer(),
      floatingActionButton: VxBuilder(
          builder: (context, store, status) => FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(context, MyRoutes.cartRoute);
            },
            backgroundColor: context.theme.buttonColor,
            child: Icon(Icons.shopping_cart_rounded),
          ).badge(size: 20, count: _cart.items.length, textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          mutations: {AddMutation, RemoveMutation}
      ),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CatalogHeader(),
                if(CatalogModel.items.isNotEmpty)
                  CatalogList().py16().expand()
                else
                  Center(child: CircularProgressIndicator().centered().expand())
              ],
            ),
          )
      ),
    );
  }
}










/*(
appBar: AppBar(
title: Text('Dummy Appbar'),
),
drawer: MyDrawer(),
body: Padding(
padding: const EdgeInsets.all(15.0),
child: (CatalogModel.items.isNotEmpty) ? ListView.builder(
itemCount: CatalogModel.items.length,
itemBuilder: (context, index) {
return ItemWidget(item: CatalogModel.items[index],);
},
): Center(child: CircularProgressIndicator(),) ,
),
) */

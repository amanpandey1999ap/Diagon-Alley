import 'package:diagon_alley/models/catalog.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key, required this.item}) :  super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.network(item.image),
        title: Text(item.name),
        subtitle: Text(item.desc),
        trailing: Text("${item.price.toString()}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        onTap: (){},
      ),
    );
  }
}

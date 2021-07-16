import 'package:diagon_alley/core/store.dart';
import 'package:diagon_alley/models/catalog.dart';
import 'package:velocity_x/velocity_x.dart';

class CartModel{

  late CatalogModel _catalog;
  final List<int> _itemIDs = [];

  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog){
    _catalog = newCatalog;
  }

  //get items in cart
  List<Item> get items => _itemIDs.map((id) => _catalog.getById(id)).toList();

  //get total price
  num get totalPrice => items.fold(0, (totalValue, current) => totalValue + current.price);


}

class AddMutation extends VxMutation<MyStore>{
  final Item item;
  AddMutation(this.item);

  @override
  perform() {
    store!.cart._itemIDs.add(item.id);
  }
}

class RemoveMutation extends VxMutation<MyStore>{
  final Item item;
  RemoveMutation(this.item);

  @override
  perform() {
    store!.cart._itemIDs.remove(item.id);
  }
}

class Item{
  final int id;
  final String name;
  final String desc;
  final num price;
  final String color;
  final String image;

  Item({required this.id, required this.name, required this.desc, required this.price, required this.color, required this.image});

  factory Item.fromMap(Map<String, dynamic> map){
    return
        // Item(
        //     map["id"],
        //     map["name"],
        //     map["description"],
        //     map["price"],
        //     map["color"],
        //     map["imageUrl"]
        // );

      Item(
      id: map["id"],
      name: map["name"],
      desc: map["desc"],
      price: map["price"],
      color: map["color"],
      image: map["image"]
    );
  }

  toMap(){
    return{
      "id" : id,
      "name" : name,
      "description" : desc,
      "price" : price,
      "color" : color,
      "imageUrl" : image
    };
  }

}

class CatalogModel{

  static List<Item> items

   = [

    Item(id: 0,
        name: 'Loading',
        desc: 'Loading',
        price: 0,
        color: "#33505a",
        image: "https://png.pngtree.com/png-clipart/20190619/original/pngtree-vector-picture-icon-png-image_4013511.jpg"
    )


    // Item(1,
    //     'Galaxy S4',
    //     'Life Companion',
    //     999,
    //     "#33505a",
    //     "https://static.toiimg.com/photo/54180308/Samsung-Galaxy-S4-I9505-16GB-LTE.jpg"
    // )

    ];

  //get item by ID
   Item getById(int id) => items.firstWhere((element) => element.id == id, orElse: null);

  //get item by Position
   Item getByPosition(int pos) => items[pos];

}
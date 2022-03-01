class MyProduct {
  String id, name, description, image_url;
  num price;

  MyProduct({this.id, this.name, this.description, this.price, this.image_url});

  toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = this.name;
    map['description'] = this.description;
    map['price'] = this.price;
    map['image_url'] = this.image_url;
    return map;
  }

  MyProduct.fromMap(Map map) {
    this.name = map['name'];
    this.id = map['id'];
    this.description = map['description'];
    this.price = map['price'];
    this.image_url = map['image_url'];
  }
}

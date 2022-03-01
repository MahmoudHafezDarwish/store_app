class MyUser {
   String id, name, address, phoneNumber, email, password,display_picture ,favourite_products;
   bool isAdmin;


   MyUser(
       {this.name,
      this.id,
      this.isAdmin,
      this.address,
      this.phoneNumber,
      this.email,
      this.password ,
       this.display_picture,
       this.favourite_products});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['firstName'] = this.name;
    map['id'] = this.id;
    map['lastName'] = this.address;
    map['phoneNumber'] = this.phoneNumber;
    map['email'] = this.email;
    map['password'] = this.password;
    map['display_picture'] = this.display_picture;
    map['favourite_products'] = this.favourite_products;
    return map;
  }

  MyUser.fromMap(Map map){
    this.name = map['firstName'];
    this.id = map['id'];
    this.address = map['lastName'];
    this.phoneNumber = map['phoneNumber'];
    this.email = map['email'];
    this.password = map['password'];
    this.display_picture = map['display_picture'];
    this.favourite_products = map['favourite_products'];
    this.isAdmin = map['isAdmin'] ?? false;
  }
}

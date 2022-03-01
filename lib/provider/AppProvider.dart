import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:store_app/data/AuthFirebas.dart';
import 'package:store_app/data/RouterHelper.dart';
import 'package:store_app/data/firebase_firestore.dart';
import 'package:store_app/generated/l10n.dart';
import 'package:store_app/models/MyUsres.dart';
import 'package:store_app/models/my_product.dart';
import 'package:store_app/screens/add_new_product.dart';
import 'package:store_app/screens/login_screen.dart';

import 'dart:developer';
import 'dart:io';

import 'package:store_app/utile/tost.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    getAllProduct();
  }

  MyUser loggedUser;

  String image_url;
  File file;
  List<MyProduct> allProduct;
  String category ='Hand bag';

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  getAllProduct() async {
    // await MyFirebaseFireStore.myFirebaseFireStore.getAllProducts();
    this.allProduct =
        await MyFirebaseFireStore.myFirebaseFireStore.getCategories('hand bag');
    notifyListeners();
  }

  pickNewImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(file.path);
    notifyListeners();
  }

  signUp(MyUser myUser) async {
    try {
      String userId = await MyAuthFirebase.instance
          .creatAccount(myUser.email, myUser.password);
      myUser.id = userId;
      await MyFirebaseFireStore.myFirebaseFireStore.createUserInFs(myUser);
      this.loggedUser = myUser;
      RouterHelper.routerHelper.pushToSpecificScreenByNameWithPop('/main');
      ToastMessage.showToast("Is Done signUp", true);
    } on Exception catch (e) {
      ToastMessage.showToast("Is Exception", false);
      print(
          'Excepton toString : ${e.toString()} :: runtimeType ${e.runtimeType}');
    }
  }

  login(String email, String password) async {
    try {
      UserCredential userCredential =
          await MyAuthFirebase.instance.sigIn(email, password);
      await getUserFromFirebase();
      if (userCredential != null) {
        ToastMessage.showToast("Is Done", true);
        RouterHelper.routerHelper.pushToSpecificScreenByNameWithPop('/main');
      }
    } on Exception catch (e) {
      print(
          'Excepton toString : ${e.toString()} :: runtimeType ${e.runtimeType}');
      ToastMessage.showToast("Is Exception", false);
    }
  }

  getUserFromFirebase() async {
    String userid = FirebaseAuth.instance.currentUser.uid;
    this.loggedUser =
        await MyFirebaseFireStore.myFirebaseFireStore.getUserFromFs(userid);
    notifyListeners();
  }

  logout() async {
    this.loggedUser = null;
    await MyAuthFirebase.instance.logout();
    RouterHelper.routerHelper.routingToSpecificWidget(LoginScreen());
  }

  addProduct() async {
    String image_url =
        await MyFirebaseFireStore.myFirebaseFireStore.uploadImage(this.file);
    MyProduct product = MyProduct(
        image_url: image_url,
        description: descriptionController.text,
        price: num.parse(priceController.text),
        name: nameController.text);
    await MyFirebaseFireStore.myFirebaseFireStore.addProduct(product, category);
    getAllProduct();
    Navigator.of(RouterHelper.routerHelper.routerKey.currentState.context)
        .pop();
  }

  addToCart(MyProduct product) async {
    await MyFirebaseFireStore.myFirebaseFireStore.addProductToCart(product.id);
  }

  editProduct(String productId) async {
    if (file != null) {
      this.image_url =
          await MyFirebaseFireStore.myFirebaseFireStore.uploadImage(this.file);
    }
    MyProduct product = MyProduct(
        description: descriptionController.text,
        price: num.parse(priceController.text),
        name: nameController.text);
    product.image_url = image_url;
    await MyFirebaseFireStore.myFirebaseFireStore
        .editProduct(product, category);
    getAllProduct();
    Navigator.of(RouterHelper.routerHelper.routerKey.currentState.context)
        .pop();
  }

  goToEditProduct(MyProduct product) {
    this.file = null;
    this.nameController.text = product.name;
    this.descriptionController.text = product.description;
    this.priceController.text = product.price.toString();
    this.image_url = product.image_url;
    notifyListeners();
    RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddNewProduct(
      isForEdit: true,
      productId: product.id,
    ));
  }

  deleteProduct(MyProduct productiD) async {
    await MyFirebaseFireStore.myFirebaseFireStore.deleteProduct(productiD,category);
    getAllProduct();
  }
}

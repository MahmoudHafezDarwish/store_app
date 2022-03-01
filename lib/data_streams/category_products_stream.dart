

import 'package:store_app/data/firebase_firestore.dart';
import 'package:store_app/models/Product.dart';

import 'data_stream.dart';

class CategoryProductsStream extends DataStream<List<String>> {
  final ProductType category;

  CategoryProductsStream(this.category);
  @override
  void reload() {
    final allProductsFuture =
    MyFirebaseFireStore.myFirebaseFireStore.getCategoryProductsList(category);
    allProductsFuture.then((favProducts) {
      addData(favProducts);
    }).catchError((e) {
      addError(e);
    });
  }
}

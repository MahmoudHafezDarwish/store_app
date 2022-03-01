

import 'package:store_app/data/firebase_firestore.dart';

import 'data_stream.dart';

class AllProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final allProductsFuture = MyFirebaseFireStore.myFirebaseFireStore.allProductsList;
    allProductsFuture.then((favProducts) {
      addData(favProducts);
    }).catchError((e) {
      addError(e);
    });
  }
}

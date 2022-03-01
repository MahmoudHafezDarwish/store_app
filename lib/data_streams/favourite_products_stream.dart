

import 'package:store_app/data/firebase_firestore.dart';

import 'data_stream.dart';

class FavouriteProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final favProductsFuture = MyFirebaseFireStore.myFirebaseFireStore.usersFavouriteProductsList;
    favProductsFuture.then((favProducts) {
      addData(favProducts.cast<String>());
    }).catchError((e) {
      addError(e);
    });
  }
}

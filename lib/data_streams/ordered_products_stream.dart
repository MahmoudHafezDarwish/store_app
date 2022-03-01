

import 'package:store_app/data/firebase_firestore.dart';

import 'data_stream.dart';

class OrderedProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final orderedProductsFuture = MyFirebaseFireStore.myFirebaseFireStore.orderedProductsList;
    orderedProductsFuture.then((data) {
      addData(data);
    }).catchError((e) {
      addError(e);
    });
  }
}

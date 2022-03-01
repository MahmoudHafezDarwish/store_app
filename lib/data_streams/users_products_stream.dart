

import 'package:store_app/data/firebase_firestore.dart';

import 'data_stream.dart';

class UsersProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final usersProductsFuture = MyFirebaseFireStore.myFirebaseFireStore.usersProductsList;
    usersProductsFuture.then((data) {
      addData(data);
    }).catchError((e) {
      addError(e);
    });
  }
}



import 'package:store_app/data/firebase_firestore.dart';

import 'data_stream.dart';

class AddressesStream extends DataStream<List<String>> {
  @override
  void reload() {
    final addressesList = MyFirebaseFireStore.myFirebaseFireStore.addressesList;
    addressesList.then((list) {
      addData(list);
    }).catchError((e) {
      addError(e);
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:store_app/data/firebase_firestore.dart';

import '../models/OrderedProduct.dart';
import '../utile/utils.dart';
import 'async_progress_dialog.dart';

class PaymentInput extends StatefulWidget {
  @override
  _PaymentInputState createState() => _PaymentInputState();
}

class _PaymentInputState extends State<PaymentInput> {
  TextEditingController pay_number;
  TextEditingController pay_date;
  TextEditingController pay_ccv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pay_number = TextEditingController();
    pay_date = TextEditingController();
    pay_ccv = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 319,
              height: 320,
              color: Colors.white,
              margin: EdgeInsetsDirectional.only(start: 28, end: 28, top: 40),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: pay_number,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      fontFamily: "Besley-Medium",
                      color: Colors.blue,
                    ),
                    decoration: InputDecoration(
                      hintText: "6524 2541 2164",
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   color: Colors.blue,
                      // ),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: "Besley-Regular",
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      controller: pay_date,
                      obscureText: false,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        fontFamily: "Besley-Regular",
                        color: Colors.blue,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.only(start: 10),
                        hintText: "MM/YY",
                        // prefixIcon: Icon(
                        //   Icons.password,
                        //   color: Colors.blue,
                        // ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          fontFamily: "Besley-Regular",
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: pay_ccv,
                      obscureText: true,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        fontFamily: "Besley-Regular",
                        color: Colors.blue,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.only(start: 10),
                        hintText: "CCV",
                        // prefixIcon: Icon(
                        //   Icons.password,
                        //   color: Colors.blue,
                        // ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          fontFamily: "Besley-Regular",
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      padding: EdgeInsetsDirectional.all(20),
                      onPressed: () async{
                        await checkoutButtonCallback();
                        Navigator.pushNamed(context, "/PaymentSuccessful");
                        print(
                            "Email: ${pay_number.text}  Password : ${pay_date.text}");
                      },
                      color: Colors.lightBlue,
                      textColor: Colors.white70,
                      child: Text(
                        "Proceed",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          fontFamily: "Besley-Regular",
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> checkoutButtonCallback() async {
    final confirmation = await showConfirmationDialog(
      context,
      "This is just a Project Testing App so, no actual Payment Interface is available.\nDo you want to proceed for Mock Ordering of Products?",
    );
    if (confirmation == false) {
      return;
    }
    final orderFuture = MyFirebaseFireStore.myFirebaseFireStore.emptyCart();
    orderFuture.then((orderedProductsUid) async {
      if (orderedProductsUid != null) {
        print(orderedProductsUid);
        final dateTime = DateTime.now();
        final formatedDateTime =
            "${dateTime.day}-${dateTime.month}-${dateTime.year}";
        List<OrderedProduct> orderedProducts = orderedProductsUid
            .map((e) => OrderedProduct(null,
            productUid: e, orderDate: formatedDateTime))
            .toList();
        bool addedProductsToMyProducts = false;
        String snackbarmMessage;
        try {
          addedProductsToMyProducts =
          await MyFirebaseFireStore.myFirebaseFireStore.addToMyOrders(orderedProducts);
          if (addedProductsToMyProducts) {
            snackbarmMessage = "Products ordered Successfully";
          } else {
            throw "Could not order products due to unknown issue";
          }
        } on FirebaseException catch (e) {
          Logger().e(e.toString());
          snackbarmMessage = e.toString();
        } catch (e) {
          Logger().e(e.toString());
          snackbarmMessage = e.toString();
        } finally {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackbarmMessage ?? "Something went wrong"),
            ),
          );
        }
      } else {
        throw "Something went wrong while clearing cart";
      }
      await showDialog(
        context: context,
        builder: (context) {
          return AsyncProgressDialog(
            orderFuture,
            message: Text("Placing the Order"),
          );
        },
      );
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AsyncProgressDialog(
          orderFuture,
          message: Text("Placing the Order"),
        );
      },
    );
  }

}

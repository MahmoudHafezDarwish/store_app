import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:store_app/data/AuthFirebas.dart';
import 'package:store_app/data/firebase_firestore.dart';
import 'package:store_app/provider/AppProvider.dart';
import 'package:store_app/widgets/producat_details_text_widget.dart';
import 'package:store_app/widgets/product_details_card_widget.dart';

import '../models/Product.dart';
import '../utile/constants.dart';
import '../utile/utils.dart';
import '../widgets/async_progress_dialog.dart';
import 'bottom_home_navigation.dart';

class ProductDtails extends StatefulWidget {
  final String productId;

  const ProductDtails({
    Key key,
    this.productId,
  }) : super(key: key);

  @override
  _ProductDtailsState createState() => _ProductDtailsState();
}

class _ProductDtailsState extends State<ProductDtails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
        elevation: 5,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: FutureBuilder(
            future: MyFirebaseFireStore.myFirebaseFireStore
                .getProductWithID(this.widget.productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Product product = snapshot.data;

                return Stack(
                  children: [
                    Column(
                      children: [
                        ProductDeailsCard(
                          order_name: product.title,
                          image: product.images[0],
                          order_price: '${product.discountPrice}\$',
                          add_to_cart: product.favourite,
                          category: product.productType,
                        ),
                        Divider(
                          height: 30,
                          thickness: 2,
                          color: Color(0xffE8E8E8),
                        ),
                        ProductDetailDescription(product.description),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 315,
                          height: 53,
                          child: ElevatedButton(
                            onPressed: () async {
                              bool allowed = MyAuthFirebase.instance.currentUser!=null;
                              if (!allowed) {
                                final reverify = await showConfirmationDialog(context,
                                    "You haven't verified your email address. This action is only allowed for verified users.",
                                    positiveResponse: "Resend verification email",
                                    negativeResponse: "Go back");
                                if (reverify) {
                                  final future =
                                  MyAuthFirebase.instance.vrifyEmail();
                                  await showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AsyncProgressDialog(
                                        future,
                                        message: Text("Resending verification email"),
                                      );
                                    },
                                  );
                                }
                                return;
                              }
                              bool addedSuccessfully = false;
                              String snackbarMessage;
                              try {
                                addedSuccessfully =
                                await MyFirebaseFireStore.myFirebaseFireStore.addProductToCart(widget.productId);
                                if (addedSuccessfully == true) {

                                  snackbarMessage = "Product added successfully";
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreenBottom(
                                                  cameIndex: 1,
                                                )));
                                } else {
                                  snackbarMessage = "Coulnd't add product due to unknown reason";
                                  throw "Coulnd't add product due to unknown reason";
                                }
                              } on FirebaseException catch (e) {
                                Logger().w("Firebase Exception: $e");
                                snackbarMessage = "Something went wrong";
                              } catch (e) {
                                Logger().w("Unknown Exception: $e");
                                snackbarMessage = "Something went wrong";
                              } finally {
                                Logger().i(snackbarMessage);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(snackbarMessage),
                                  ),
                                );
                              }
                            },
                            // onPressed: () {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => HomeScreenBottom(
                            //                 cameIndex: 1,
                            //               )));
                            // },
                            child: Text('ADD TO CART'),
                            style: ElevatedButton.styleFrom(
                              textStyle: TextStyle(
                                fontFamily: 'Besley-ExtraBold',
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              primary: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                final error = snapshot.error.toString();
                Logger().e(error);
              }
              return Center(
                child: Icon(
                  Icons.error,
                  color: kTextColor,
                  size: 60,
                ),
              );
            }),
      ),
    );
  }
}

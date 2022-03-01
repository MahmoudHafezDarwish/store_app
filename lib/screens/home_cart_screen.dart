import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:store_app/data/firebase_firestore.dart';
import 'package:store_app/widgets/cart_item_widget.dart';
import 'package:store_app/widgets/product_card_widget.dart';

import '../data_streams/cart_items_stream.dart';
import '../models/CartItem.dart';
import '../models/Product.dart';
import '../utile/constants.dart';
import '../utile/size_config.dart';
import '../utile/utils.dart';
import '../widgets/async_progress_dialog.dart';
import '../widgets/nothingtoshow_container.dart';

class HomeCartScreen extends StatefulWidget {
  const HomeCartScreen({Key key}) : super(key: key);

  @override
  _HomeCartScreenState createState() => _HomeCartScreenState();
}

class _HomeCartScreenState extends State<HomeCartScreen> {
  final CartItemsStream cartItemsStream = CartItemsStream();
  PersistentBottomSheetController bottomSheetHandler;

  @override
  void initState() {
    // TODO: implement initState
    cartItemsStream.init();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cartItemsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                    height: SizeConfig.screenHeight * 0.75,
                    child: Center(child: buildCartItemsList())),
                // Container(
                //   margin: EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Row(
                //         children: [
                //           Text("Sub total:",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.normal,
                //                 fontSize: 22,
                //                 fontFamily: "Besley-Regular",
                //                 color: Colors.black.withOpacity(0.5),
                //               )),
                //           Spacer(),
                //           Text('100\$',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.normal,
                //                 fontSize: 20,
                //                 fontFamily: "Besley-Regular",
                //                 color: Colors.grey,
                //               )),
                //         ],
                //       ),
                //       SizedBox(
                //         height: 5,
                //       ),
                //       Row(
                //         children: [
                //           Text("Tax(15%):",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.normal,
                //                 fontSize: 22,
                //                 fontFamily: "Besley-Regular",
                //                 color: Colors.black.withOpacity(0.5),
                //               )),
                //           Spacer(),
                //           Text('15\$',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.normal,
                //                 fontSize: 20,
                //                 fontFamily: "Besley-Regular",
                //                 color: Colors.grey,
                //               )),
                //         ],
                //       ),
                //       Divider(
                //         thickness: 2,
                //         height: 15,
                //         color: Colors.grey.shade300,
                //       ),
                //       Row(
                //         children: [
                //           Text("Total:",
                //               style: TextStyle(
                //                 fontWeight: FontWeight.normal,
                //                 fontSize: 22,
                //                 fontFamily: "Besley-Regular",
                //                 color: Colors.black.withOpacity(0.5),
                //               )),
                //           Spacer(),
                //           Text('115\$',
                //               style: TextStyle(
                //                 fontWeight: FontWeight.normal,
                //                 fontSize: 20,
                //                 fontFamily: "Besley-Regular",
                //                 color: Colors.grey,
                //               )),
                //         ],
                //       ),
                //       Container(
                //         width: 315,
                //         height: 53,
                //         margin: EdgeInsetsDirectional.only(top: 10),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             Navigator.pushNamed(context, "/PaymentMode");
                //           },
                //           child: Text('Checkout'),
                //           style: ElevatedButton.styleFrom(
                //             textStyle: TextStyle(
                //               fontFamily: 'Besley-ExtraBold',
                //               fontWeight: FontWeight.w800,
                //               fontSize: 16,
                //               color: Colors.white,
                //             ),
                //             primary: Colors.blue,
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(30)),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //       Container(
                //         width: 315,
                //         height: 53,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             Navigator.pushNamed(context, "/homeCartScreen");
                //           },
                //           child: Text(
                //             'Cancel Order',
                //             style: TextStyle(
                //               color: Colors.black,
                //             ),
                //           ),
                //           style: ElevatedButton.styleFrom(
                //             textStyle: TextStyle(
                //               fontFamily: 'Besley-ExtraBold',
                //               fontWeight: FontWeight.w800,
                //               fontSize: 16,
                //               color: Colors.yellow,
                //             ),
                //             primary: Colors.white,
                //             shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(30)),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         height: 10,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    cartItemsStream.reload();
    return Future<void>.value();
  }

  Widget buildCartItemsList() {
    return StreamBuilder<List<String>>(
      stream: cartItemsStream.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> cartItemsId = snapshot.data;
          if (cartItemsId.length == 0) {
            return Center(
              child: NothingToShowContainer(
                iconPath: "assets/icons/empty_cart.svg",
                secondaryMessage: "Your cart is empty",
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Positioned(
                      right: 30,
                      top: 20,
                      left: 30,
                      bottom: 10,
                      child: Text(
                        "${cartItemsId.length} items available",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Besley-Medium',
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      physics: BouncingScrollPhysics(),
                      itemCount: cartItemsId.length,
                      itemBuilder: (context, index) {
                        if (index >= cartItemsId.length) {
                          return SizedBox(
                              height: getProportionateScreenHeight(80));
                        }
                        return buildCartItem(cartItemsId[index], index);
                        // return buildCartItemDismissible(
                        //     context, cartItemsId[index], index);
                      },
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(
                          start: 20, end: 20, top: 20),
                      child: FutureBuilder<num>(
                          future:
                              MyFirebaseFireStore.myFirebaseFireStore.cartTotal,
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              final cartTotal = snapshot.data;
                              final sumTotal = cartTotal*0.15;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text("Sub total:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22,
                                            fontFamily: "Besley-Regular",
                                            color: Colors.black.withOpacity(0.5),
                                          )),
                                      Spacer(),
                                      Text('${cartTotal}\$',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            fontFamily: "Besley-Regular",
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text("Tax(15%):",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22,
                                            fontFamily: "Besley-Regular",
                                            color: Colors.black.withOpacity(0.5),
                                          )),
                                      Spacer(),
                                      Text('${sumTotal}\$',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            fontFamily: "Besley-Regular",
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 15,
                                    color: Colors.grey.shade300,
                                  ),
                                  Row(
                                    children: [
                                      Text("Total:",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22,
                                            fontFamily: "Besley-Regular",
                                            color: Colors.black.withOpacity(0.5),
                                          )),
                                      Spacer(),
                                      Text('${sumTotal+cartTotal}\$',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            fontFamily: "Besley-Regular",
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  Container(
                                    width: 315,
                                    height: 53,
                                    margin: EdgeInsetsDirectional.only(top: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/PaymentMode");
                                      },
                                      child: Text('Checkout'),
                                      style: ElevatedButton.styleFrom(
                                        textStyle: TextStyle(
                                          fontFamily: 'Besley-ExtraBold',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        primary: Colors.blue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 315,
                                    height: 53,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, "/homeCartScreen");
                                      },
                                      child: Text(
                                        'Cancel Order',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        textStyle: TextStyle(
                                          fontFamily: 'Besley-ExtraBold',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color: Colors.yellow,
                                        ),
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }else if (snapshot.hasError) {
                              final error = snapshot.error;
                              Logger().w(error.toString());
                              return Center(
                                child: Text(
                                  error.toString(),
                                ),
                              );
                            } else {
                              return Center(
                                child: Icon(
                                  Icons.error,
                                ),
                              );
                            }

                          }),
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   margin: EdgeInsetsDirectional.only(
                    //       start: 10, end: 10, top: 46),
                    //   child: Column(
                    //     children: [
                    //       // CardItemForCart(
                    //       //   image: 'images/bag_black.png',
                    //       //   product_name: 'Handbag',
                    //       // ),
                    //       // SizedBox(
                    //       //   height: 10,
                    //       // ),
                    //       // CardItemForCart(
                    //       //   image: 'images/big_bag.png',
                    //       //   product_name: 'Backpack',
                    //       // ),
                    //       // SizedBox(
                    //       //   height: 10,
                    //       // ),
                    //       // CardItemForCart(
                    //       //   image: 'images/bag.png',
                    //       //   product_name: 'Backpack',
                    //       // ),
                    //       SizedBox(
                    //         height: 10,
                    //       ),
                    //     ],
                    //   ),
                    //   // child: GridView(
                    //   //   scrollDirection: Axis.vertical,
                    //   //   padding: EdgeInsets.all(5),
                    //   //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   //       crossAxisCount: 1,
                    //   //       crossAxisSpacing: 10,
                    //   //       mainAxisSpacing: 10),
                    //   //   children: [
                    //   //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
                    //   //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
                    //   //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
                    //   //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
                    //   //
                    //   //   ],
                    //   // ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        return Center(
          child: NothingToShowContainer(
            iconPath: "assets/icons/network_error.svg",
            primaryMessage: "Something went wrong",
            secondaryMessage: "Unable to connect to Database",
          ),
        );
      },
    );
  }

  Widget buildCartItem(String cartItemId, int index) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 4,
        top: 4,
        right: 4,
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: kTextColor.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(15),
      ),
      // margin: EdgeInsetsDirectional.only(start: 10, end: 10, top: 46),
      child: FutureBuilder<Product>(
          future: MyFirebaseFireStore.myFirebaseFireStore
              .getProductWithID(cartItemId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Product product = snapshot.data;
              return Container(
                // width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
/*
          borderRadius: BorderRadius.only(

             topLeft: Radius.circular(10),
             bottomRight: Radius.circular(10),
          ),
          */
                  ),
                  //margin: EdgeInsets.only(top: 10, bottom: 10, left: 18, right: 23),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage(product.images[0]),
                        height: 82,
                        width: 87,
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                                fontFamily: "Besley-Regular",
                                color: Colors.black,
                              )),
                          SizedBox(
                            height: 2,
                          ),
                          Text(product.variant,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                fontFamily: "Besley-Regular",
                                color: Color(0xffA1A1B4),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("\$${product.discountPrice}",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                fontFamily: "Besley-Regular",
                                color: Colors.black,
                              )),
                        ],
                      ),
                      Spacer(),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            iconSize: 30,
                            color: Colors.black,
                            onPressed: () async {
                              final confirmation = await showConfirmationDialog(
                                context,
                                "Remove Product from Cart?",
                              );
                              if (confirmation) {
                                bool result = false;
                                String snackbarMessage;
                                try {
                                  result = await MyFirebaseFireStore
                                      .myFirebaseFireStore
                                      .removeProductFromCart(cartItemId);
                                  if (result == true) {
                                    snackbarMessage =
                                        "Product removed from cart successfully";
                                    await refreshPage();
                                  } else {
                                    throw "Coulnd't remove product from cart due to unknown reason";
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
                                print("$result delete");

                                return result;
                              }
                              return false;
                            },
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 30,
                                color: Colors.black,
                                onPressed: () async {
                                  await increaseCountCallback(cartItemId);
                                },
                              ),
                              FutureBuilder<CartItem>(
                                  future: MyFirebaseFireStore
                                      .myFirebaseFireStore
                                      .getCartItemFromId(cartItemId),
                                  builder: (context, snapshot) {
                                    int itemCount = 0;
                                    if (snapshot.hasData) {
                                      final cartItem = snapshot.data;
                                      itemCount = cartItem.itemCount;
                                      return Text("$itemCount",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22,
                                            fontFamily: "Besley-Regular",
                                            color: Colors.black,
                                          ));
                                    } else if (snapshot.hasError) {
                                      final error = snapshot.error.toString();
                                      Logger().e(error);
                                    }
                                    return Center(
                                      child: Icon(
                                        Icons.error,
                                      ),
                                    );
                                  }),
                              IconButton(
                                icon: Icon(Icons.remove),
                                iconSize: 30,
                                color: Colors.black,
                                onPressed: () async {
                                  await decreaseCountCallback(cartItemId);
                                  print("decreaseCountCallback");
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              final error = snapshot.error;
              Logger().w(error.toString());
              return Center(
                child: Text(
                  error.toString(),
                ),
              );
            } else {
              return Center(
                child: Icon(
                  Icons.error,
                ),
              );
            }
          }),
      // child: GridView(
      //   scrollDirection: Axis.vertical,
      //   padding: EdgeInsets.all(5),
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 1,
      //       crossAxisSpacing: 10,
      //       mainAxisSpacing: 10),
      //   children: [
      //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
      //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
      //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
      //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
      //
      //   ],
      // ),
    );
  }

  Future<void> increaseCountCallback(String cartItemId) async {
    final future = MyFirebaseFireStore.myFirebaseFireStore
        .increaseCartItemCount(cartItemId);
    future.then((status) async {
      if (status) {
        await refreshPage();
      } else {
        throw "Couldn't perform the operation due to some unknown issue";
      }
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AsyncProgressDialog(
          future,
          message: Text("Please wait"),
        );
      },
    );
  }

  Future<void> decreaseCountCallback(String cartItemId) async {
    final future = MyFirebaseFireStore.myFirebaseFireStore
        .decreaseCartItemCount(cartItemId);
    future.then((status) async {
      if (status) {
        await refreshPage();
      } else {
        throw "Couldn't perform the operation due to some unknown issue";
      }
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AsyncProgressDialog(
          future,
          message: Text("Please wait"),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:store_app/data/firebase_firestore.dart';
import 'package:store_app/utile/size_config.dart';

import '../models/Product.dart';
import '../utile/constants.dart';

class ProductCard extends StatelessWidget {
  final String order_name;
  final String order_price;
  final bool add_to_cart;
  final String image;
  final String productId;
  final GestureTapCallback press;

  ProductCard(
      {this.order_name,
      this.order_price,
      this.add_to_cart,
      this.image,
      this.productId,
      this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(width: 2, color: Colors.blue),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: FutureBuilder<Product>(
            future: MyFirebaseFireStore.myFirebaseFireStore.getProductWithID(productId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final Product product = snapshot.data;
                return buildProductCardItems(product);
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Center(child: CircularProgressIndicator()),
                );
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
            },
          ),
        ),
        // child: Stack(
        //   children: [
        //     PositionedDirectional(
        //       top: 5,
        //       end: 10,
        //       child: CircleAvatar(
        //         child: Icon(
        //           add_to_cart == true
        //               ? Icons.favorite
        //               : Icons.favorite_outline_outlined,
        //           color: add_to_cart == true ? Colors.red : Colors.grey,
        //           size: 25,
        //         ),
        //         //radius: 40,
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Image(
        //             image: NetworkImage(image),
        //             height: 70,
        //             width: 70,
        //             fit: BoxFit.fill,
        //           ),
        //           Padding(
        //             padding: EdgeInsetsDirectional.only(top: 10),
        //             child: Text(this.order_name,
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.normal,
        //                   fontSize: 22,
        //                   fontFamily: "Besley-Regular",
        //                   color: Colors.black,
        //                 )),
        //           ),
        //           Text(this.order_price,
        //               style: TextStyle(
        //                 fontWeight: FontWeight.normal,
        //                 fontSize: 20,
        //                 fontFamily: "Besley-Regular",
        //                 color: Colors.grey,
        //               )),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Stack buildProductCardItems(Product product){
    return Stack(
      children: [
        PositionedDirectional(
          top: 5,
          end: 5,
          child: CircleAvatar(

            child: Icon(
              product.favourite == true
                  ? Icons.favorite
                  : Icons.favorite_outline_outlined,
              color: add_to_cart == true ? Colors.red : Colors.grey,
              size: 25,
            ),
            //radius: 40,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(product.images[0]),
                height: 70,
                width: 70,
                fit: BoxFit.fill,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 10),
                child: Text(product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 22,
                      fontFamily: "Besley-Regular",
                      color: Colors.black,
                    )),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 5,
                      child: Text.rich(
                        TextSpan(
                          text: "\₹${product.discountPrice}\n",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          children: [
                            TextSpan(
                              text: "\₹${product.originalPrice}",
                              style: TextStyle(
                                color: kTextColor,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.normal,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Stack(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/DiscountTag.svg",
                            color: kPrimaryColor,
                          ),
                          Center(
                            child: Text(
                              "${product.calculatePercentageDiscount()}%\nOff",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Text(this.order_price,
              //     style: TextStyle(
              //       fontWeight: FontWeight.normal,
              //       fontSize: 20,
              //       fontFamily: "Besley-Regular",
              //       color: Colors.grey,
              //     )),
            ],
          ),
        ),
      ],
    );
  }
}

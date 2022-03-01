import 'package:flutter/material.dart';
import 'package:store_app/models/Product.dart';

class ProductDeailsCard extends StatelessWidget {
  final String order_name;
  final String order_price;
  final bool add_to_cart;
  final String image;
  final ProductType category;

  ProductDeailsCard(
      {this.order_name,
      this.order_price,
      this.add_to_cart,
      this.image,
      this.category});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(width: 2, color: Colors.blue),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            top: 5,
            end: 10,
            child: Container(
              decoration: BoxDecoration(),
              child: Icon(
                add_to_cart == true
                    ? Icons.favorite
                    : Icons.favorite_outline_outlined,
                color: add_to_cart == true ? Colors.red : Colors.grey,
                size: 25,
              ),
              //radius: 40,
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 20,end: 20,top: 10,bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image(
                    image: NetworkImage(image),
                    height: 218,
                    width: 289,
                    fit: BoxFit.fill,
                  ),
                ),
                Row(
                  children: [
                    Text(this.order_name,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          fontFamily: "Besley-Regular",
                          color: Colors.black,
                        )),
                    Spacer(),
                    Text(this.order_price,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          fontFamily: "Besley-Regular",
                          color: Colors.grey,
                        )),
                  ],
                ),
                Text('${this.category}',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,

                      fontSize: 20,
                      fontFamily: "Besley-Regular",
                      color: Colors.grey,
                    ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_app/data/firebase_firestore.dart';
import 'package:store_app/models/Product.dart';

class CardItemForCart extends StatefulWidget {
  String image ='';
  String cartitemid ='';
  String product_name;
  Product product;


  CardItemForCart({this.cartitemid, this.product_name,this.product});

  @override
  _CardItemForCartState createState() => _CardItemForCartState(image,product_name);
}

class _CardItemForCartState extends State<CardItemForCart> {
  String image ='';
  String product_name;


  _CardItemForCartState(this.image, this.product_name);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              image: AssetImage(image),
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
                Text(widget.product.title,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 22,
                      fontFamily: "Besley-Regular",
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 2,
                ),
                Text(widget.product.variant,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: "Besley-Regular",
                      color: Color(0xffA1A1B4),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text("\$${widget.product.discountPrice}",
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
                  onPressed: () {
                    print("search");
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
                      onPressed: () {
                        print("search");
                      },
                    ),
                    Text("2",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 22,
                          fontFamily: "Besley-Regular",
                          color: Colors.black,
                        )),
                    IconButton(
                      icon: Icon(Icons.remove),
                      iconSize: 30,
                      color: Colors.black,
                      onPressed: () {
                        print("remove");
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
  }


}

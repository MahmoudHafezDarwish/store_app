import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItemForHistoryCart extends StatefulWidget {
  String image ='';
  String product_name;


  CardItemForHistoryCart({this.image, this.product_name});

  @override
  _CardItemForCartState createState() => _CardItemForCartState(image,product_name);
}

class _CardItemForCartState extends State<CardItemForHistoryCart> {
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
                Text(product_name,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 22,
                      fontFamily: "Besley-Regular",
                      color: Colors.black,
                    )),
                SizedBox(
                  height: 2,
                ),
                Text("from boots category",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      fontFamily: "Besley-Regular",
                      color: Color(0xffA1A1B4),
                    )),
                SizedBox(
                  height: 10,
                ),
                Text("\$120",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      fontFamily: "Besley-Regular",
                      color: Colors.black,
                    )),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

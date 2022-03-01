import 'package:flutter/material.dart';

class PaymentCardWidget extends StatelessWidget {
  const PaymentCardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: double.infinity,
      height: 214,
      child: Card(
        elevation: 5,
        color: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(width: 2, color: Colors.blue),
        ),
        child: Stack(
          children: [
            PositionedDirectional(
              top: 5,
              start: 10,
              child: Container(
                decoration: BoxDecoration(),
                child: Icon(
                  Icons.payment,
                  color: Colors.white,
                  size: 25,
                ),
                //radius: 40,
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(
                  start: 20, end: 20, top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text('1234 5678 9876 5432',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 22,
                              fontFamily: "Besley-Regular",
                              color: Colors.black,
                            )),
                        Text("1234",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                              fontFamily: "Besley-Regular",
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('Mahmoud Darwish',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            fontFamily: "Besley-Regular",
                            color: Colors.black,
                          )),
                      Spacer(),
                      Text(
                        "EXPIRY",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 8,

                          fontFamily: "Besley-Regular",
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(width: 7,),
                      Text("03/17",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20,
                            fontFamily: "Besley-Regular",
                            color: Colors.white,
                          )),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

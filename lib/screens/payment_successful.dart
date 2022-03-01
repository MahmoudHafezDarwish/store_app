import 'package:flutter/material.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text('Payment Successful'),
      ),
      body: Center(
        child: Container(
          width: 319,
          height: 320,
          color: Colors.white,
          margin: EdgeInsetsDirectional.only(start: 28, end: 28, top: 40),
          child: Column(
            children: [
              Image(
                image: AssetImage('images/success_pay_image.png'),
                height: 98,
                width: 89,
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Payment Successful",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                  fontFamily: "Besley-Regular",
                  color: Colors.black,
                ),
              ),Text(
                "We have emailed you the receipt.",
                textAlign: TextAlign.center,
                style: TextStyle(

                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  fontFamily: "Besley-Regular",
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsetsDirectional.all(20),
                  onPressed: () {
                    Navigator.pushNamed(context, "/RatingScreen");
                  },
                  color: Colors.lightBlue,
                  textColor: Colors.white70,
                  child: Text(
                    "Finish!",
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
      ),
    );
  }
}

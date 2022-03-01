import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutBoardingContentScreen extends StatelessWidget {
  final String title ;
  final String subTitle ;
  final String image ;



  OutBoardingContentScreen({this.title, this.subTitle, this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Image(
          alignment: Alignment.topCenter,
          fit: BoxFit.fill,
          image: AssetImage(image),
          height: 283,
          width: double.infinity,
        ),

        Text(
          title,
          style: TextStyle(
              fontFamily: 'Besley-Bold',
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: Colors.black,
              backgroundColor: Colors.transparent),
        ),Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Besley-Regular',
              fontWeight: FontWeight.normal,
              fontSize: 24,
              color: Colors.black,
              backgroundColor: Colors.transparent),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class MainOrderCard extends StatelessWidget {
  final String image;

  MainOrderCard({@required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 198,
      child: Card(
        elevation: 1,
        color: Color(0xffF0F1F6),

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(10),

          side: BorderSide(
            width: 0,
            color: Color(0xffE8E9EE),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(image),
              height: 143,
              width: 137,
              fit: BoxFit.fill,
            )
          ],
        ),
      ),
    );
  }
}

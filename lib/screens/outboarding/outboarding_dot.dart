import 'package:flutter/material.dart';

class OutBoardingDot extends StatelessWidget {
  final int index;

  final int currentIndex;

  OutBoardingDot({this.index, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 20,
      height: 5,
      decoration: BoxDecoration(
        color: index==currentIndex ?Colors.blue:Colors.grey,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}

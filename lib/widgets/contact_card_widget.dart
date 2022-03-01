import 'package:flutter/material.dart';
import 'package:store_app/utile/size_config.dart';

class GridCard extends StatelessWidget {
  final String name;
  final String number;

  const GridCard({this.name = '', this.number = ''});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(width: 2, color: Colors.blue),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            child: Icon(
              Icons.gradient,
              color: Colors.black26,
              size: 25,
            ),
            radius: 40,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 10),
            child: Text(this.name,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 24,
                  fontFamily: "Tajawal",
                  color: Colors.black,
                )),
          ),
          Text(this.number,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                fontFamily: "Tajawal",
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProductDetailDescription extends StatelessWidget {
  final String _description ;

  ProductDetailDescription(this._description);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            _description,
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Besley-Regular',
              color: Colors.black.withOpacity(0.7)
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}

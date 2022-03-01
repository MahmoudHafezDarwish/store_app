import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  String label;
  TextEditingController editingController;
  TextInputType textInputType =TextInputType.text;
  Function validation ;
  Function saved ;


  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        keyboardType: widget.textInputType,
        controller: widget.editingController,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 20,
          fontFamily: "Besley-Medium",
          color: Colors.blue,
        ),
        validator: (value)=>widget.validation(value),
        onSaved: (value) =>widget.saved,
        decoration: InputDecoration(
          hintText: widget.label,
          prefixIcon: Icon(
            Icons.person,
            color: Colors.blue,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            fontFamily: "Besley-Regular",
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}

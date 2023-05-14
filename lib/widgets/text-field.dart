import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  TextEditingController controller;
  TextInputType? textInputType;
  String title;
  final Function validator;
  TextFormFieldWidget(
      {required this.title,
      required this.validator,
      required this.controller,
      this.textInputType});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      validator: (x) => validator(x),
      decoration: InputDecoration(
        label: Text(title),
        //hintStyle:TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        labelStyle: TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}

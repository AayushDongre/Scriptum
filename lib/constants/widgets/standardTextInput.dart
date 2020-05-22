import 'package:flutter/material.dart';


final InputDecoration standardInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(30),
    ),
    errorStyle: TextStyle(color: Colors.redAccent),
    disabledBorder: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 24, bottom: 11, top: 11, right: 15),
    hintStyle: TextStyle(color: Colors.white54),
    filled: true,
    fillColor: Color(0xFF111111));

Container standardTextInput({
  @required String hintText,
  @required TextEditingController controller,
  @required String Function(String) validator,
  bool obscureText = false,
  double margin = 8,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8),
    margin: EdgeInsets.symmetric(vertical: margin),
    child: TextFormField(
      controller: controller,
      autovalidate: true,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      decoration: standardInputDecoration.copyWith(hintText: hintText),
      obscureText: obscureText,
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';

//TODO: style snackbar
Widget snackbar(String text, IconData icon) {
  return SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        h2(text, fontSize: 14),
        Icon(
          icon,
          color: Colors.white54,
        ),
      ],
    ),
    backgroundColor: Color(0XFF111111),
  );
}

final InputDecoration standardInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(30),
    ),
    errorStyle: TextStyle(color: Colors.redAccent),
    disabledBorder: InputBorder.none,
    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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

Widget button(
  BuildContext context,
  String text, {
  @required void Function() onTap,
  double width = 0.8,
  double height = 48,
  Color color,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: MediaQuery.of(context).size.width * width,
      height: height,
      child: Center(child: h2(text, fontSize: 20)),
      decoration: BoxDecoration(
        color: color ?? purple,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );
}

Widget folder(String title) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(16),
    height: 100,
    width: 100,
    child: h2(title),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF2F353A), Color(0xFF1C1F22).withOpacity(.8481)],
            transform: GradientRotation(6.12))),
  );
}

Widget smallFolder(String title) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.only(right: 8),
    height: 50,
    width: 200,
    child: h1(title, fontSize: 24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF2F353A), Color(0xFF1C1F22).withOpacity(.8481)],
        transform: GradientRotation(6.12),
      ),
    borderRadius: BorderRadius.all(Radius.circular(24))
    ),

  );
}

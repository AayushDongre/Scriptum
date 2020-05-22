import 'package:flutter/material.dart';
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

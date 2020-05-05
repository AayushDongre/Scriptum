import 'package:flutter/material.dart';

Text h1(String text, {double fontSize}) {
  return Text(
    text,
    style: TextStyle(
      color: Color(0XFFFDFDFD),
      letterSpacing: -0.4,
      fontSize: fontSize ?? 28,
      fontWeight: FontWeight.bold,
      fontFamily: 'Lato',
    ),
  );
}

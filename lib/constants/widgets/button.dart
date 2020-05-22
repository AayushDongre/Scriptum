import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';


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

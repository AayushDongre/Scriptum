import 'package:flutter/material.dart';
import 'package:scriptum/constants/typography.dart';

Widget noteTag({String tag, Color color = Colors.white}) {
  return Container(
    margin: EdgeInsets.all(8),
    child: Container(
      padding: EdgeInsets.all(4),
      child: h2(tag, fontSize: 16),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}

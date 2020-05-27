import 'package:flutter/material.dart';
import 'package:scriptum/constants/typography.dart';




Widget folder(String title) {
  return Container(
    alignment: Alignment.center,
    margin: EdgeInsets.all(16),
    height: 100,
    width: 100,
    child: Center(child: h2(title, fontSize: 24)),
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xFF2F353A), Color(0xFF1C1F22).withOpacity(.8481)],
            transform: GradientRotation(6.12))),
  );
}



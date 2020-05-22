import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text h1(String text, {double fontSize}) {
  return Text(
    text,
    style:GoogleFonts.poppins(
      color: Color(0XFFFDFDFD),
      letterSpacing: -0.4,
      fontSize: fontSize ?? 28,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text h2(String text, {double fontSize}) {
  return Text(
    text,
    style: GoogleFonts.quicksand(
       color: Color(0XFFFDFDFD),
      letterSpacing: 0.4,
      fontSize: fontSize ?? 28,
      fontWeight: FontWeight.w600,
    ),
    // style: TextStyle(
    //   color: Color(0XFFFDFDFD),
    //   letterSpacing: 0.4,
    //   fontSize: fontSize ?? 28,
    //   fontWeight: FontWeight.w600,
    //   fontFamily: 'Lato',
    // ),
  );
}
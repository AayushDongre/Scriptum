import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            h1('SCRIPTUM'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Image.asset(
                'assets/transparentLogo.png',
                height: 125.0,
                width: 122.0,
              ),
            ),
          ],
        )),
      ),
    );
  }
}

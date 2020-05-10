import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/screens/authentication/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 24, left: 16),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: h1('Sign Up', fontSize: 48),
                ),
                SignUpForm(),
              ],
            ),
          ),
      ),
    );
  }
}

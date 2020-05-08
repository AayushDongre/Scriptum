import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';

class UploadScreen extends StatefulWidget {
  File file;

  UploadScreen({Key key, @required this.file}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(color: Colors.white,),
    );
  }
}
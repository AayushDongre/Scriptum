import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/screens/upload/upload_form.dart';

class UploadScreen extends StatefulWidget {
  final File file;
  UploadScreen({Key key, @required this.file}) : super(key: key);

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<String> tags = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: h1('Upload'),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 16),
                height: MediaQuery.of(context).size.width * 0.4,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Image.file(
                  widget.file,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(tags.toString())
                  ],
                ),
              ),
            ],
          ),
          UploadForm(
            file: widget.file,
            callbackState: callbackState
          ),
        ],
      ),
    );
  }
  callbackState(String newTag){
    if(!tags.contains(newTag)){
      setState(() {
        tags.add(newTag);
      });
    }
  }
}

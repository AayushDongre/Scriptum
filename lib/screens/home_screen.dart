import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scriptum/authentication/authBloc/auth_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/models/user.dart';
import 'package:scriptum/screens/upload/upload_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
User user;

  @override
  void initState() { 
    super.initState();
    user = context.repository<AuthRepository>().currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: h1('HOME'),
        actions: <Widget>[
          RaisedButton(
              child: h2('Logout'),
              onPressed: () => context.bloc<AuthBloc>().add(LoggedOut()))
        ],
      ),
      body: Container(
        color: backgroundColor,
        child: ListView(
          children: <Widget>[
            h1(user.name)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          print('yess');
          File file = await ImagePicker.pickImage(source: ImageSource.camera);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UploadScreen(
                  file: file,
                  user: user,
                ),
              ));
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

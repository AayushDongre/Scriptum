import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authBloc/auth_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: h1('HOME'),
      ),
      body: Container(
        color: backgroundColor,
        child: ListView(
          children: <Widget>[
            Text('yeas')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print(context.repository<AuthRepository>().currentUser),
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

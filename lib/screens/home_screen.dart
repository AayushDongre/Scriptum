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
            h1(context.repository<AuthRepository>().currentUser.name)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print(''),
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}

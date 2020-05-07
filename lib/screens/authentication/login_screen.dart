import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/authentication/loginBloc/login_bloc.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/screens/authentication/login_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRepository _authRepository = AuthRepository();
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(authRepository: _authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocProvider(
          bloc: _loginBloc,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 24, left: 16),
            child: Column(
              children: <Widget>[
                h1('Sign In', fontSize: 48),
                LoginForm(),
                Text('OR'),
                RaisedButton(
                  child: Text('Sign up'),
                  onPressed: () => Navigator.pushNamed(context, '/signup'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}

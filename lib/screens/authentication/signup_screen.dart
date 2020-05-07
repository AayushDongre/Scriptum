import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/authentication/signupBloc/signup_bloc.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/typography.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthRepository _authRepository = AuthRepository();
  SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _signupBloc = SignupBloc(authRepository: _authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: BlocProvider(
          bloc: _signupBloc,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 24, left: 16),
            child: Column(
              children: <Widget>[
                h1('Sign Up'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _signupBloc.dispose();
    super.dispose();
  }
}

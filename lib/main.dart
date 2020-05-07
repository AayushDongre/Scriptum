import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authBloc/auth_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/screens/authentication/login_screen.dart';
import 'package:scriptum/screens/authentication/signup_screen.dart';
void main() => runApp(Scriptum());

class Scriptum extends StatefulWidget {
  Scriptum({Key key}) : super(key: key);

  @override
  _ScriptumState createState() => _ScriptumState();
}

class _ScriptumState extends State<Scriptum> {
  
  final AuthRepository _authRepository = AuthRepository();
  AuthBloc _authBloc;
  
  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(authRepository: _authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      bloc: _authBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/signup' : (BuildContext context) => SignUpScreen(),
          '/login' : (BuildContext  context) => LoginScreen(),
        },
        theme: ThemeData.dark(),
        home: BlocBuilder(
          bloc: _authBloc,
          builder: (BuildContext context, AuthState state) {
            if ( state is AuthInitial ){
              return LoginScreen();
            } else if ( state is Authenticated ) {
              return Container(child: h1(state.user.name));
            }
            else {
              return Container();
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() { 
    _authBloc.dispose();
    super.dispose();
  }
}

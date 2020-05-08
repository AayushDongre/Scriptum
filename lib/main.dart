import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authBloc/auth_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/constants/typography.dart';
import 'package:scriptum/screens/authentication/login_screen.dart';
import 'package:scriptum/screens/authentication/signup_screen.dart';
import 'package:scriptum/screens/home_screen.dart';
import 'package:scriptum/screens/splash_screen.dart';
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
    _authBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext context) => _authBloc,
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
            if ( state is Authenticated ) {
              // _authBloc.dispatch(LoggedOut());
              return RepositoryProvider(
                create: (context) => _authRepository,
                child: HomeScreen(),
              );
            }
            if ( state is AuthInitial ){
              return SplashScreen();
            } 
            else  {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
  @override
  void dispose() { 
    _authBloc.close();
    super.dispose();
  }
}

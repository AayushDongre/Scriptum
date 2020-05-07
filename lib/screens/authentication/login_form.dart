import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authBloc/auth_bloc.dart';
import 'package:scriptum/authentication/loginBloc/login_bloc.dart';
import 'package:scriptum/constants/widgets.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(emailListener);
    _passwordController.addListener(passwordListener);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: _loginBloc,
        listener: blocListener,
        child: BlocBuilder(
          bloc: _loginBloc,
          builder: (BuildContext context, LoginState state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: Form(
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    standardTextInput(
                      hintText: 'Email Address',
                      controller: _emailController,
                      validator: (value) =>
                          !state.isEmailValid ? 'Invalid Email' : null,
                    ),
                    standardTextInput(
                      hintText: 'Password',
                      controller: _passwordController,
                      validator: (value) =>
                          !state.isPasswordValid ? 'Invalid Password' : null,
                      obscureText: true,
                      margin: 16,
                    ),
                    button(
                      context,
                      'Log In',
                      onTap: () {
                        if (state.isFormValid &&
                            _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          _loginBloc.dispatch(CredentialSignIn(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ));
                        } else {
                          Scaffold.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                                snackbar('Please Enter Valid Details', Icons.error));
                        }
                      },
                    ),
                    Text('OR'),
                    button(
                      context,
                      'Sign Up',
                      onTap: () => Navigator.pushNamed(context, '/signup'),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  void blocListener(BuildContext context, LoginState state) {
    if (!state.emailIsCorrect) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
            snackbar('Account for this email does not exit', Icons.error));
    }
    if (!state.passwordIsCorrect) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackbar('Wrong Password', Icons.error));
    }
    if (state.isFailure) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackbar('Something went wrong!', Icons.error));
    }
    if (state.isSubmitting) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackbar('Logging In', Icons.timer));
    }
    if (state.isSuccesful) {
      BlocProvider.of<AuthBloc>(context).dispatch(LoggedIn());
    }
    print(state);
  }

  void emailListener() {
    _loginBloc.dispatch(
      EmailChanged(email: _emailController.text),
    );
  }

  void passwordListener() {
    _loginBloc.dispatch(
      PasswordChanged(password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authBloc/auth_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/authentication/signupBloc/signup_bloc.dart';
import 'package:scriptum/constants/widgets/button.dart';
import 'package:scriptum/constants/widgets/snackbar.dart';
import 'package:scriptum/constants/widgets/standardTextInput.dart';
import 'package:scriptum/database/dbRepository.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(onEmailChanged);
    _emailController.addListener(onPasswordChanged);
    _signupBloc = SignupBloc(authRepository: context.repository<AuthRepository>(), dbRepository: context.repository<DBRepository>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _signupBloc,
      listener: blocListener,
      child: BlocBuilder(
        bloc: _signupBloc,
        builder: (BuildContext context, SignupState state) {
          return Container(
              padding: EdgeInsets.all(16),
              child: Form(
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    standardTextInput(
                        hintText: 'Name',
                        controller: _nameController,
                        validator: (value) =>
                            (value.length > 2) || value.isEmpty
                                ? null
                                : 'Please enter your name',
                        margin: 16),
                    standardTextInput(
                        hintText: 'Email Adress',
                        controller: _emailController,
                        validator: (value) =>
                            !state.isEmailValid ? 'Invalid Email' : null,
                        margin: 16),
                    standardTextInput(
                        hintText: 'Password',
                        controller: _passwordController,
                        validator: (value) =>
                            !state.isPasswordValid ? 'Invalid Password' : null,
                        obscureText: true,
                        margin: 16),
                    button(
                      context,
                      'Sign Up',
                      onTap: () {
                        if (state.isFormValid &&
                            _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty &&
                            _nameController.text.length > 2) {
                          _signupBloc.add(
                            SignUpSubmitted(
                              email: _emailController.text,
                              password: _passwordController.text,
                              name: _nameController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  void blocListener(BuildContext context, SignupState state) {
    if (state.isSubmitting) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackbar('Submitting', Icons.timer));
    }
    if (state.emailInUse) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackbar('This email is already in use!', Icons.error));
    }
    if (state.isFailure) {
      Scaffold.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackbar('Something went wrong!', Icons.error));
    }
    if (state.isSuccess) {
      BlocProvider.of<AuthBloc>(context).add(LoggedIn());
      Navigator.pop(context);
    }
  }

  void onEmailChanged() {
    _signupBloc.add(
      SignUpEmailChanged(email: _emailController.text),
    );
  }

  void onPasswordChanged() {
    _signupBloc.add(
      SignUpPasswordChanged(password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signupBloc.close();
    super.dispose();
  }
}

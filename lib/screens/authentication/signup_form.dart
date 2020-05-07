import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/authentication/signupBloc/signup_bloc.dart';
import 'package:scriptum/constants/colors.dart';
import 'package:scriptum/constants/widgets.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthRepository _authRepository = AuthRepository();
  SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(onEmailChanged);
    _emailController.addListener(onPasswordChanged);
    _signupBloc = SignupBloc(authRepository: _authRepository);
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
                            value.isEmpty ? 'Please enter your name' : null,
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
                    RaisedButton(
                      color: Colors.white,
                      child: Text(
                        'Submit',
                        style: TextStyle(color: purple),
                      ),
                      onPressed: () {
                        if (state.isFormValid &&
                            _emailController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) {
                          print('sdf');
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

  void blocListener(BuildContext context, SignupState state) {}

  void onEmailChanged() {
    _signupBloc.dispatch(
      SignUpEmailChanged(email: _emailController.text),
    );
  }

  void onPasswordChanged() {
    _signupBloc.dispatch(
      SignUpPasswordChanged(password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _signupBloc.dispose();
    super.dispose();
  }
}

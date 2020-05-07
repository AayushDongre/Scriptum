import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:scriptum/authentication/authRepository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository _authRepository;

  LoginBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  @override
  LoginState get initialState => LoginState.initial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* emailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* passwordChangedToState(event.password);
    } else if (event is CredentialSignIn) {
      yield* credentialSignInToState(event.email, event.password);
    } else if (event is GoogleSignIn) {
      yield* googleSignInToState();
    }
  }


  Stream<LoginState> emailChangedToState(String email) async* {
    yield  currentState.copyWith(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> passwordChangedToState(String password) async* {
    yield currentState.update(
        isPasswordvalid: Validators.isValidPassword(password));
  }

  Stream<LoginState> credentialSignInToState(
    String email,
    String password,
  ) async* {
    yield LoginState.submitting();
    try {
      await _authRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (e) {
      print(e.code);
      if (e.code == 'ERROR_USER_NOT_FOUND') {
        yield LoginState.incorrectEmail();
      } else if (e.code == 'ERROR_WRONG_PASSWORD') {
        yield LoginState.incorrectPassword();
      } else {
        yield LoginState.failure();
      }
    }
  }

  Stream<LoginState> googleSignInToState() async* {
    yield LoginState.submitting();
    try {
      await _authRepository.signInWithGoogle();
      yield LoginState.success();
    } catch (e) {
      yield LoginState.failure();
    }
  }
}

class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email) || email.isEmpty;
  }

  static isValidPassword(String password) {
    return password.length > 5;
  }
}

import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/authentication/validators.dart';
import 'package:scriptum/database/dbRepository.dart';
import 'package:scriptum/models/user.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository _authRepository;
  DBRepository _dbRepository;

  SignupBloc(
      {@required AuthRepository authRepository,
      @required DBRepository dbRepository})
      : assert(authRepository != null),
        assert(dbRepository != null),
        _dbRepository = dbRepository,
        _authRepository = authRepository;

  @override
  SignupState get initialState => SignupState.initial();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is SignUpEmailChanged) {
      yield* mapEmailChangedToState(event.email);
    }
    if (event is SignUpPasswordChanged) {
      yield* mapPasswordChangedToState(event.password);
    }
    if (event is SignUpSubmitted) {
      yield* mapSubmittedToState(event.email, event.password, event.name);
    }
  }

  Stream<SignupState> mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<SignupState> mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<SignupState> mapSubmittedToState(
    String email,
    String password,
    String name,
  ) async* {
    yield SignupState.submitting();
    try {
      User user = await _authRepository.signUpWithEmailAndPassword(
          email, password, name);
      await _dbRepository.initialiseUser(user);
      yield SignupState.success();
    } catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        yield SignupState.emailInUse();
      } else {
        yield SignupState.failure();
      }
    }
  }
}

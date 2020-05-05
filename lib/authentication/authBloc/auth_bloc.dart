import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:scriptum/authentication/authRepository.dart';
import 'package:scriptum/models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({@required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository;

  @override
  AuthState get initialState => AuthInitial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* appStartedToState();
    } else if (event is LoggedIn) {
      yield* loggedInToState();
    } else if (event is LoggedOut) {
      yield* loggedOutToState();
    }
  }

  Stream<AuthState> appStartedToState() async* {
    final bool isSignedIn = await _authRepository.isSignIn();
    if (isSignedIn) {
      final User user = await _authRepository.getCurrentUser();
      yield Authenticated(user);
    } else {
      yield UnAuthenticated();
    }
  }

  Stream<AuthState> loggedInToState() async* {
    final User user = await _authRepository.getCurrentUser();
    yield Authenticated(user);
  }

  Stream<AuthState> loggedOutToState() async* {
    yield UnAuthenticated();
  }
}

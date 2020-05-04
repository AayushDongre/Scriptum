part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState([List props = const []]);
}


class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Initial UnAuthenticated state';
}


class Authenticated extends AuthState{
  FirebaseUser user;

  Authenticated(this.user) : super([user]);

  @override
  String toString() => 'Authenticated State';
}


class UnAuthenticated extends AuthState{
  @override
  String toString() => 'UnAuthenticated State';
}

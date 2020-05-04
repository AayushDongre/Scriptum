part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable{
  AuthEvent([List props = const []]);
}


class AppStarted extends AuthEvent{
  @override
  String toString() => 'App Started';
}

class LoggedIn extends AuthEvent{
  @override
  String toString() => 'User Logged In';
}

class LoggedOut extends AuthEvent{
  @override
  String toString() => 'User Logged out';
}
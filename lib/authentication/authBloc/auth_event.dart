part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super();
}

class AppStarted extends AuthEvent {
  List<Object> get props => [];

  @override
  String toString() => 'App Started';
}

class LoggedIn extends AuthEvent {
  List<Object> get props => [];

  @override
  String toString() => 'User Logged In';
}

class LoggedOut extends AuthEvent {
  List<Object> get props => [];

  @override
  String toString() => 'User Logged out';
}

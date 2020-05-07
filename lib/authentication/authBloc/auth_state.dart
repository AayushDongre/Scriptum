part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super([props]);
}


class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Initial UnAuthenticated state';
}


class Authenticated extends AuthState{
  final User user;

  Authenticated(this.user) : super([user]);

  @override
  String toString() => 'Authenticated State';
}


class UnAuthenticated extends AuthState{
  @override
  String toString() => 'UnAuthenticated State';
}

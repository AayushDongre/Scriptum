part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super();
}


class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'Initial UnAuthenticated state';
}


class Authenticated extends AuthState{
  final User user;

  List<Object> get props => [user];

  Authenticated(this.user) : super([user]);

  @override
  String toString() => 'Authenticated(${user.toString()})';
}


class UnAuthenticated extends AuthState{
  List<Object> get props => [];

  @override
  String toString() => 'UnAuthenticated State';
}

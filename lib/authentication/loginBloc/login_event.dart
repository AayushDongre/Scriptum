part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([props = const []]) : super([props]);
}

class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged(email: $email)';
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged(password: $password)';
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() => 'Submitted(email: $email, password: $password)';
}

class CredentialSignIn extends LoginEvent {
  final String email;
  final String password;

  CredentialSignIn({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() => 'CredentialSignIn(email: $email, password: $password)';
}

class GoogleSignIn extends LoginEvent {
  @override
  String toString() => 'GoogleSignIn()';
}

part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  LoginEvent([props = const []]) : super();
}

class EmailChanged extends LoginEvent {
  final String email;

  List<Object> get props => [email];

  EmailChanged({@required this.email}) : super([email]);

  @override
  String toString() => 'EmailChanged(email: $email)';
}

class PasswordChanged extends LoginEvent {
  final String password;

  List<Object> get props => [password];

  PasswordChanged({@required this.password}) : super([password]);

  @override
  String toString() => 'PasswordChanged(password: $password)';
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  List<Object> get props => [email, password];

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

  List<Object> get props => [email, password];

  CredentialSignIn({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() => 'CredentialSignIn(email: $email, password: $password)';
}

class GoogleSignIn extends LoginEvent {
  List<Object> get props => [];
  
  @override
  String toString() => 'GoogleSignIn()';
}

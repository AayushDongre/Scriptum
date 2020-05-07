part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  SignupEvent([props = const []]) : super([props]);
}

class SignUpEmailChanged extends SignupEvent {
  final String email;

  SignUpEmailChanged({@required this.email})
      : assert(email != null),
        super([email]);

  @override
  String toString() => 'SignUpEmailChanged(email: $email)';
}

class SignUpPasswordChanged extends SignupEvent {
  final String password;

  SignUpPasswordChanged({@required this.password})
      : assert(password != null),
        super([password]);

  @override
  String toString() => 'SignUpPasswordChanged(password: $password)';
}

class SignUpSubmitted extends SignupEvent {
  final String email;
  final String password;
  final String name;

  SignUpSubmitted({
    @required this.email,
    @required this.password,
    @required this.name
  })  : assert(email != null),
        assert(password != null),
        assert(name != null),
        super([email, password, name]);

  @override
  String toString() => 'SignUpSubmitted(email: $email, password: $password, name: $name)';
}

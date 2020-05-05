part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccesful;
  final bool isFailure;

  LoginState._({
    this.isEmailValid,
    this.isPasswordValid,
    this.isSubmitting,
    this.isSuccesful,
    this.isFailure,
  });

  factory LoginState.initial() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccesful: false,
      isFailure: false,
    );
  }

  factory LoginState.submitting() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccesful: false,
      isFailure: false,
    );
  }

  factory LoginState.success() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccesful: true,
      isFailure: false,
    );
  }

  factory LoginState.failure(){
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccesful: false,
      isFailure: true
    );
  }
}

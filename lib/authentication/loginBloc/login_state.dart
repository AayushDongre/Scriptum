part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccesful;
  final bool isFailure;
  final bool emailIsCorrect;
  final bool passwordIsCorrect;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState._({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccesful,
    @required this.isFailure,
    @required this.emailIsCorrect,
    @required this.passwordIsCorrect,
  });

  factory LoginState.initial() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccesful: false,
      isFailure: false,
      emailIsCorrect: true,
      passwordIsCorrect: true,
    );
  }

  factory LoginState.submitting() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccesful: false,
      isFailure: false,
      emailIsCorrect: true,
      passwordIsCorrect: true,
    );
  }

  factory LoginState.success() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccesful: true,
      isFailure: false,
      emailIsCorrect: true,
      passwordIsCorrect: true,
    );
  }

  factory LoginState.failure() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccesful: false,
      isFailure: true,
      emailIsCorrect: true,
      passwordIsCorrect: true,
    );
  }

  factory LoginState.incorrectEmail() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccesful: false,
      isFailure: true,
      emailIsCorrect: false,
      passwordIsCorrect: true,
    );
  }

  factory LoginState.incorrectPassword() {
    return LoginState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccesful: false,
      isFailure: true,
      emailIsCorrect: true,
      passwordIsCorrect: false,
    );
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccesful,
    bool isFailure,
    bool emailIsCorrect,
    bool passwordIsCorrect,
  }) {
    return LoginState._(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccesful: isSuccesful ?? this.isSuccesful,
      isFailure: isFailure ?? this.isFailure,
      emailIsCorrect: emailIsCorrect ?? this.emailIsCorrect,
      passwordIsCorrect: passwordIsCorrect ?? passwordIsCorrect,
    );
  }

  LoginState update({
    bool isEmailValid,
    bool isPasswordvalid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordvalid,
      isSubmitting: false,
      isSuccesful: false,
      isFailure: false,
      emailIsCorrect: true,
      passwordIsCorrect: true,
    );
  }

  @override
  String toString() {
    return '''LoginState(
      isEmailValid: $isEmailValid, 
      isPasswordValid: $isPasswordValid, 
      isSubmitting: $isSubmitting, 
      isSuccesful: $isSuccesful, 
      isFailure: $isFailure)''';
  }
}

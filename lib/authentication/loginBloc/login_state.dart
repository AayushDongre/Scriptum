part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccesful;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState._({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccesful,
    @required this.isFailure,
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

  factory LoginState.failure() {
    return LoginState._(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccesful: false,
        isFailure: true);
  }

  LoginState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccesful,
    bool isFailure,
  }) {
    return LoginState._(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccesful: isSuccesful ?? this.isSuccesful,
      isFailure: isFailure ?? this.isFailure,
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

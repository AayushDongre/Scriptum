part of 'signup_bloc.dart';

@immutable
class SignupState extends Equatable {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool emailInUse;

  get isFormValid => isEmailValid && isPasswordValid;

  SignupState._({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
    @required this.emailInUse
  })  : assert(isEmailValid != null),
        assert(isPasswordValid != null),
        assert(isSubmitting != null),
        assert(isSuccess != null),
        assert(isFailure != null),
        assert(emailInUse != null),
        super([
          isEmailValid,
          isPasswordValid,
          isSubmitting,
          isSuccess,
          isFailure,
          emailInUse,
        ]);

  factory SignupState.initial() {
    return SignupState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      emailInUse: false,
    );
  }

  factory SignupState.submitting() {
    return SignupState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      emailInUse: false,
    );
  }

  factory SignupState.success() {
    return SignupState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      emailInUse: false,
    );
  }

  factory SignupState.failure() {
    return SignupState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      emailInUse: false,
    );
  }

  factory SignupState.emailInUse() {
    return SignupState._(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      emailInUse: true,
    );
  }

  SignupState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
    bool emailInUse,
  }) {
    return SignupState._(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      emailInUse: emailInUse ?? this.emailInUse,
    );
  }

  SignupState update({
    bool isEmailValid,
    bool isPasswordValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      emailInUse: false,
    );
  }

  @override
  String toString() {
    return '''SignupState(
      isEmailValid: $isEmailValid, 
      isPasswordValid: $isPasswordValid, 
      isSubmitting: $isSubmitting, 
      isSuccess: $isSuccess, 
      isFailure: $isFailure),
      emailInUse: $emailInUse''';
  }
}

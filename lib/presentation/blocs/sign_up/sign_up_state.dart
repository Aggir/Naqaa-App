part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  final Status signUpStatus;
  final String? errorMessage;
  const SignUpState({
    this.signUpStatus = Status.initial,
    this.errorMessage,
  });
  @override
  List<Object?> get props => [signUpStatus, errorMessage];

  SignUpState copyWith({
    Status? signUpStatus,
    String? errorMessage,
  }) {
    return SignUpState(
      signUpStatus: signUpStatus ?? this.signUpStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({this.signInStatus = Status.initial, this.errorMessage});

  final Status signInStatus;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        signInStatus,
        errorMessage,
      ];

  SignInState copyWith({
    Status? signInStatus,
    String? errorMessage,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

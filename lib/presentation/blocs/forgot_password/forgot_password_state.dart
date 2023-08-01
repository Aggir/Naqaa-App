part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends Equatable {
  final Status sendResetInstructionsStatus;
  final String? errorMessage;
  const ForgotPasswordState({
    this.sendResetInstructionsStatus = Status.initial,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({
    Status? sendResetInstructionsStatus,
    String? errorMessage,
  }) {
    return ForgotPasswordState(
      sendResetInstructionsStatus:
          sendResetInstructionsStatus ?? this.sendResetInstructionsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [sendResetInstructionsStatus, errorMessage];
}

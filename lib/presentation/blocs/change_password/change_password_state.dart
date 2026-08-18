part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.changePasswordStatus = Status.initial,
    this.errorMessage,
  });
  final Status changePasswordStatus;
  final String? errorMessage;

  @override
  List<Object?> get props => [changePasswordStatus, errorMessage];

  ChangePasswordState copyWith({
    Status? changePasswordStatus,
    String? errorMessage,
  }) {
    return ChangePasswordState(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

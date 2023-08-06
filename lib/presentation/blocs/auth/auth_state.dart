part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.authStatus = Status.initial,
    this.authErrorMessage,
    this.editProfileStatus = Status.initial,
    this.editProfileErrorMessage,
  });

  final UserEntity? user;
  final Status authStatus;
  final String? authErrorMessage;
  final Status editProfileStatus;
  final String? editProfileErrorMessage;

  @override
  List<Object?> get props => [
        user,
        authStatus,
        authErrorMessage,
        editProfileStatus,
        editProfileErrorMessage,
      ];

  AuthState copyWith({
    UserEntity? user,
    Status? authStatus,
    String? authErrorMessage,
    Status? editProfileStatus,
    String? editProfileErrorMessage,
  }) {
    return AuthState(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
      authErrorMessage: authErrorMessage ?? this.authErrorMessage,
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      editProfileErrorMessage:
          editProfileErrorMessage ?? this.editProfileErrorMessage,
    );
  }
}

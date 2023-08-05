part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.user,
    this.authStatus = Status.initial,
    this.authErrorMessage,
  });

  final UserEntity? user;
  final Status authStatus;
  final String? authErrorMessage;

  @override
  List<Object?> get props => [
        user,
        authStatus,
        authErrorMessage,
      ];

  AuthState copyWith({
    UserEntity? user,
    Status? authStatus,
    String? authErrorMessage,
  }) {
    return AuthState(
      user: user,
      authStatus: authStatus ?? this.authStatus,
      authErrorMessage: authErrorMessage ?? this.authErrorMessage,
    );
  }
}

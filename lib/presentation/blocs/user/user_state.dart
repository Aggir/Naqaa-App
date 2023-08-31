part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
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

  UserState copyWith({
    UserEntity? user,
    Status? authStatus,
    String? authErrorMessage,
    Status? editProfileStatus,
    String? editProfileErrorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
      authErrorMessage: authErrorMessage ?? this.authErrorMessage,
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      editProfileErrorMessage:
          editProfileErrorMessage ?? this.editProfileErrorMessage,
    );
  }
}

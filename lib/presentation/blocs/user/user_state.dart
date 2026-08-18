part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    this.user,
    this.authStatus = Status.initial,
    this.authErrorMessage,
    this.editProfileStatus = Status.initial,
    this.editProfileErrorMessage,
    this.sendEmailVerificationStatus = Status.initial,
    this.sendEmailVerificationErrorMessage,
    this.checkEmailVerificationStatus = Status.initial,
    this.checkEmailVerificationErrorMessage,
    this.isEmailVerified,
  });

  final UserEntity? user;
  final Status authStatus;
  final String? authErrorMessage;
  final Status editProfileStatus;
  final String? editProfileErrorMessage;
  final Status sendEmailVerificationStatus;
  final String? sendEmailVerificationErrorMessage;
  final Status checkEmailVerificationStatus;
  final String? checkEmailVerificationErrorMessage;
  final bool? isEmailVerified;

  @override
  List<Object?> get props => [
        user,
        authStatus,
        authErrorMessage,
        editProfileStatus,
        editProfileErrorMessage,
        sendEmailVerificationStatus,
        sendEmailVerificationErrorMessage,
        checkEmailVerificationStatus,
        checkEmailVerificationErrorMessage,
        isEmailVerified,
      ];

  UserState copyWith({
    UserEntity? user,
    Status? authStatus,
    String? authErrorMessage,
    Status? editProfileStatus,
    String? editProfileErrorMessage,
    Status? sendEmailVerificationStatus,
    String? sendEmailVerificationErrorMessage,
    Status? checkEmailVerificationStatus,
    String? checkEmailVerificationErrorMessage,
    bool? isEmailVerified,
  }) {
    return UserState(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
      authErrorMessage: authErrorMessage ?? this.authErrorMessage,
      editProfileStatus: editProfileStatus ?? this.editProfileStatus,
      editProfileErrorMessage:
          editProfileErrorMessage ?? this.editProfileErrorMessage,
      sendEmailVerificationStatus:
          sendEmailVerificationStatus ?? this.sendEmailVerificationStatus,
      sendEmailVerificationErrorMessage: sendEmailVerificationErrorMessage ??
          this.sendEmailVerificationErrorMessage,
      checkEmailVerificationStatus:
          checkEmailVerificationStatus ?? this.checkEmailVerificationStatus,
      checkEmailVerificationErrorMessage: checkEmailVerificationErrorMessage ??
          this.checkEmailVerificationErrorMessage,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}

import 'dart:io';

import 'package:naqaa/domain/entities/user.dart';

import 'base_request.dart';

class SignInRequest implements BaseRequest {
  final String emailAddress;
  final String password;
  const SignInRequest({
    required this.emailAddress,
    required this.password,
  });
}

class SignUpRequest implements BaseRequest {
  final String fullName;
  final String emailAddress;
  final String password;
  const SignUpRequest({
    required this.fullName,
    required this.emailAddress,
    required this.password,
  });
}

class ChangePasswordRequest implements BaseRequest {
  final String oldPassword;
  final String newPassword;
  const ChangePasswordRequest({
    required this.oldPassword,
    required this.newPassword,
  });
}

class SendResetPasswordInstructionsRequest implements BaseRequest {
  final String emailAddress;
  const SendResetPasswordInstructionsRequest({
    required this.emailAddress,
  });
}

class EditProfileRequest implements BaseRequest {
  final UserEntity newUser;
  final File? pickedImage;
  const EditProfileRequest({
    required this.newUser,
    this.pickedImage,
  });
}

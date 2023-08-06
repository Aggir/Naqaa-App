import 'dart:convert';

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
  final String fullName;
  final String? genderId;
  final int? dateOfBirth;
  const EditProfileRequest({
    required this.fullName,
    this.genderId,
    this.dateOfBirth,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'genderId': genderId,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory EditProfileRequest.fromMap(Map<String, dynamic> map) {
    return EditProfileRequest(
      fullName: map['fullName'] ?? '',
      genderId: map['genderId'],
      dateOfBirth: map['dateOfBirth']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory EditProfileRequest.fromJson(String source) =>
      EditProfileRequest.fromMap(json.decode(source));
}

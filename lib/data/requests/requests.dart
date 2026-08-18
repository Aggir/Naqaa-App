import 'dart:io';

import 'package:naqaa/app/enums/statistics_date_enum.dart';
import 'package:naqaa/data/datasources/remote/firebase_constants.dart';
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

class AddDeviceRequest implements BaseRequest {
  final String name;
  final String id;
  const AddDeviceRequest({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.id: id,
      FirebaseConstants.name: name,
    };
  }
}

class EditDeviceNameRequest implements BaseRequest {
  final String newName;
  final String id;

  EditDeviceNameRequest({
    required this.newName,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.id: id,
      FirebaseConstants.name: newName,
    };
  }
}

class StatisticsRequest implements BaseRequest {
  final String deviceId;
  final StatisticsDate statisticsDate;

  StatisticsRequest({
    required this.deviceId,
    required this.statisticsDate,
  });

  Map<String, dynamic> toMap() {
    return {
      FirebaseConstants.deviceId: deviceId,
      FirebaseConstants.statisticsDate: statisticsDate.toStringEnum,
    };
  }
}

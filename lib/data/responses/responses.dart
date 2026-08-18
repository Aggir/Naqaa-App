import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/data/models/device_details_model.dart';
import 'package:naqaa/data/models/device_model.dart';
import 'package:naqaa/data/models/notification_model.dart';
import 'package:naqaa/data/models/statistic_model.dart';
import 'package:naqaa/data/models/user.dart';
import 'package:naqaa/data/responses/base_response.dart';

class AuthResponse implements BaseResponse {
  @override
  String? message;

  @override
  Status status;

  final UserModel? user;

  AuthResponse(this.status, {this.user, this.message});
}

class BasicResponse implements BaseResponse {
  @override
  String? message;

  @override
  Status status;

  BasicResponse(this.status, this.message);
}

class DevicesResponse implements BaseResponse {
  @override
  String? message;

  @override
  Status status;

  final Stream<List<DeviceModel>>? devicesStream;

  DevicesResponse({
    required this.status,
    this.message,
    this.devicesStream,
  });
}

class DeviceDetailsResponse implements BaseResponse {
  @override
  String? message;

  @override
  Status status;

  final Stream<DeviceDetailsModel>? deviceDetailsStream;

  DeviceDetailsResponse({
    required this.status,
    this.message,
    this.deviceDetailsStream,
  });
}

class NotificationsResponse implements BaseResponse {
  @override
  String? message;

  @override
  Status status;

  Stream<List<NotificationModel>>? notificationsStream;

  NotificationsResponse({
    this.message,
    required this.status,
    this.notificationsStream,
  });
}

class EmailVerificationResponse implements BaseResponse {
  @override
  String? message;

  @override
  Status status;

  bool? isEmailVerified;

  EmailVerificationResponse({
    this.message,
    required this.status,
    this.isEmailVerified,
  });
}

class StatisticsResponse implements BaseResponse {
  @override
  String? message;

  @override
  Status status;

  List<StatisticModel>? statistics;

  StatisticsResponse({
    this.message,
    required this.status,
    this.statistics,
  });

  factory StatisticsResponse.fromMap(Map<dynamic, dynamic> map) {
    return StatisticsResponse(
      message: map['message'],
      status: map['status'],
      statistics: map['statistics'] != null
          ? List<StatisticModel>.from(
              map['statistics']?.map((x) => StatisticModel.fromMap(x)))
          : null,
    );
  }
}

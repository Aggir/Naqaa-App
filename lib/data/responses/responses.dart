import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/data/models/device_details_model.dart';
import 'package:naqaa/data/models/device_model.dart';
import 'package:naqaa/data/models/notification_model.dart';
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

  Stream<NotificationModel>? notificationsStream;

  NotificationsResponse({
    this.message,
    required this.status,
    this.notificationsStream,
  });
}

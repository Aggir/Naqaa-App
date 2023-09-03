import 'package:equatable/equatable.dart';
import 'package:naqaa/app/constants.dart';

class NotificationEntity extends Equatable {
  final String userId;
  final String deviceId;
  final String deviceName;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String waterQualityName;
  final String waterQualityHex;

  const NotificationEntity({
    required this.userId,
    required this.deviceId,
    required this.deviceName,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.waterQualityName,
    required this.waterQualityHex,
  });

  factory NotificationEntity.empty() => NotificationEntity(
        userId: Constants.empty,
        deviceId: Constants.empty,
        deviceName: Constants.empty,
        isRead: false,
        createdAt: DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
        waterQualityName: Constants.empty,
        waterQualityHex: Constants.empty,
      );

  @override
  List<Object> get props {
    return [
      userId,
      deviceId,
      deviceName,
      isRead,
      createdAt,
      updatedAt,
      waterQualityName,
      waterQualityHex,
    ];
  }
}

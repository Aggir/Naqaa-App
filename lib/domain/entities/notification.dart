import 'package:equatable/equatable.dart';
import 'package:naqaa/app/constants.dart';

class NotificationEntity extends Equatable {
  final String id;
  final String userId;
  final String deviceId;
  final String deviceName;
  final bool isRead;
  final bool isSeen;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String waterQualityName;
  final String waterQualityHex;

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.deviceId,
    required this.deviceName,
    required this.isRead,
    required this.isSeen,
    required this.createdAt,
    required this.updatedAt,
    required this.waterQualityName,
    required this.waterQualityHex,
  });

  factory NotificationEntity.empty() => NotificationEntity(
        id: Constants.empty,
        userId: Constants.empty,
        deviceId: Constants.empty,
        deviceName: Constants.empty,
        isRead: false,
        isSeen: false,
        createdAt: DateTime.fromMillisecondsSinceEpoch(0),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
        waterQualityName: Constants.empty,
        waterQualityHex: Constants.empty,
      );

  @override
  List<Object> get props {
    return [
      id,
      userId,
      deviceId,
      deviceName,
      isRead,
      isSeen,
      createdAt,
      updatedAt,
      waterQualityName,
      waterQualityHex,
    ];
  }
}

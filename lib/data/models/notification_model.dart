import 'package:naqaa/data/datasources/remote/firebase_constants.dart';

class NotificationModel {
  final String? userId;
  final String? deviceId;
  final String? deviceName;
  final bool? isRead;
  final int? createdAt;
  final int? updatedAt;
  final String? waterQualityName;
  final String? waterQualityHex;

  NotificationModel({
    this.userId,
    this.deviceId,
    this.deviceName,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.waterQualityName,
    this.waterQualityHex,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      userId: map[FirebaseConstants.userId],
      deviceId: map[FirebaseConstants.deviceId],
      deviceName: map[FirebaseConstants.deviceName],
      isRead: map[FirebaseConstants.isRead],
      createdAt: map[FirebaseConstants.createdAt]?.toInt(),
      updatedAt: map[FirebaseConstants.updatedAt]?.toInt(),
      waterQualityName: map[FirebaseConstants.waterQualityName],
      waterQualityHex: map[FirebaseConstants.waterQualityHex],
    );
  }
}

import 'package:naqaa/data/datasources/remote/firebase_constants.dart';

class NotificationModel {
  final String? id;
  final String? userId;
  final String? deviceId;
  final String? deviceName;
  final bool? isRead;
  final bool? isSeen;
  final int? createdAt;
  final int? updatedAt;
  final String? waterQualityName;
  final String? waterQualityHex;

  NotificationModel({
    this.id,
    this.userId,
    this.deviceId,
    this.deviceName,
    this.isRead,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
    this.waterQualityName,
    this.waterQualityHex,
  });

  factory NotificationModel.fromMap(Map<dynamic, dynamic>? map) {
    return NotificationModel(
      id: map?[FirebaseConstants.id],
      userId: map?[FirebaseConstants.userId],
      deviceId: map?[FirebaseConstants.deviceId],
      deviceName: map?[FirebaseConstants.deviceName],
      isRead: map?[FirebaseConstants.isRead],
      isSeen: map?[FirebaseConstants.isSeen],
      createdAt: map?[FirebaseConstants.createdAt]?.toInt(),
      updatedAt: map?[FirebaseConstants.updatedAt]?.toInt(),
      waterQualityName: map?[FirebaseConstants.waterQualityName],
      waterQualityHex: map?[FirebaseConstants.waterQualityHex],
    );
  }
}

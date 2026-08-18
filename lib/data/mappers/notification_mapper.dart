import 'package:naqaa/app/constants.dart';
import 'package:naqaa/data/models/notification_model.dart';
import 'package:naqaa/domain/entities/notification.dart';

extension NotificationModelExtension on NotificationModel? {
  NotificationEntity toDomain() => this == null
      ? NotificationEntity.empty()
      : NotificationEntity(
          id: this?.id ?? Constants.empty,
          userId: this?.userId ?? Constants.empty,
          deviceId: this?.deviceId ?? Constants.empty,
          deviceName: this?.deviceName ?? Constants.empty,
          isRead: this?.isRead ?? false,
          isSeen: this?.isSeen ?? false,
          createdAt: DateTime.fromMillisecondsSinceEpoch(
              this?.createdAt ?? Constants.zero),
          updatedAt: DateTime.fromMillisecondsSinceEpoch(
              this?.updatedAt ?? Constants.zero),
          waterQualityName: this?.waterQualityName ?? Constants.empty,
          waterQualityHex: this?.waterQualityHex ?? Constants.empty,
        );
}

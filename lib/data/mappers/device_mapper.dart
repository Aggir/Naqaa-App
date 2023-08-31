import 'package:naqaa/app/constants.dart';
import 'package:naqaa/data/models/device_model.dart';
import 'package:naqaa/domain/entities/device.dart';

extension DeviceModelExtension on DeviceModel? {
  DeviceEntity toDomain() => this == null
      ? DeviceEntity.empty()
      : DeviceEntity(
          name: this?.name ?? Constants.empty,
          macAddress: this?.macAddress ?? Constants.empty,
          waterQuality:
              this?.waterQualityName?.toLowerCase() ?? Constants.empty,
          hexColor: this?.waterQualityHex ?? Constants.empty,
        );
}

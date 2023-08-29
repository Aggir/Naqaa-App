import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/data/models/device_details_model.dart';
import 'package:naqaa/domain/entities/device_details.dart';

extension DeviceDetailsModelExtension on DeviceDetailsModel? {
  DeviceDetailsEntity toDomain() => this == null
      ? DeviceDetailsEntity.empty()
      : DeviceDetailsEntity(
          phValue: this?.phValue ?? Constants.dZero,
          phMin: this?.phMin ?? Constants.dZero,
          phMax: this?.phMax ?? Constants.dZero,
          tdsValue: this?.tdsValue ?? Constants.dZero,
          tdsMin: this?.tdsMin ?? Constants.dZero,
          tdsMax: this?.tdsMax ?? Constants.dZero,
          tempValue: this?.tempValue ?? Constants.dZero,
          tempMin: this?.tempMin ?? Constants.dZero,
          tempMax: this?.tempMax ?? Constants.dZero,
          isConnected: !olderThanXSeconds(this?.updatedAt, 15),
        );
}

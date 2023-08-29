import 'package:easy_localization/easy_localization.dart';
import 'package:naqaa/app/app_strings.dart';

enum SensorType {
  temp,
  tds,
  ph,
}

extension SensorTypeExtension on SensorType {
  bool get isTemp => this == SensorType.temp;
  bool get isTds => this == SensorType.tds;
  bool get isPh => this == SensorType.ph;

  String name() {
    switch (this) {
      case SensorType.temp:
        return AppStrings.temp.tr();
      case SensorType.tds:
        return AppStrings.tds.tr();
      case SensorType.ph:
        return AppStrings.ph.tr();
    }
  }

  String unit() {
    switch (this) {
      case SensorType.temp:
        return AppStrings.tempUnit.tr();
      case SensorType.tds:
        return AppStrings.tdsUnit.tr();
      case SensorType.ph:
        return AppStrings.phUnit.tr();
    }
  }
}

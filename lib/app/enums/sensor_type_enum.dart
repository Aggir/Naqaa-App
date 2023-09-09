import 'package:easy_localization/easy_localization.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';

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

  String get svgIcon {
    switch (this) {
      case SensorType.temp:
        return SvgAssets.temp;
      case SensorType.tds:
        return SvgAssets.tds;
      case SensorType.ph:
        return SvgAssets.ph;
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

  List<SensorType> get list => [SensorType.temp, SensorType.tds, SensorType.ph];
}

extension StringToSensorTypeExtension on String {
  SensorType toSensorType() {
    String ph = AppStrings.ph.tr();
    String tds = AppStrings.tds.tr();
    if (this == ph) {
      return SensorType.ph;
    } else if (this == tds) {
      return SensorType.tds;
    } else {
      return SensorType.temp;
    }
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/functions.dart';

extension Validators on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  DateTime? get asNullableDate =>
      isNotEmpty ? DateFormat('dd/MM/yyyy').parse(this) : null;
}

extension Formatter on double {
  String asString() {
    if (this == toInt()) {
      return toInt().toString();
    } else {
      return toString();
    }
  }
}

extension WeekdayIntExtension on int {
  String get weekdayName {
    switch (this) {
      case 1:
        return AppStrings.monday.tr();
      case 2:
        return AppStrings.tuesday.tr();
      case 3:
        return AppStrings.wednesday.tr();
      case 4:
        return AppStrings.thursday.tr();
      case 5:
        return AppStrings.friday.tr();
      case 6:
        return AppStrings.saturday.tr();
      default:
        return AppStrings.sunday.tr();
    }
  }
}

extension WaterQualityExtension on int {
  String get toWaterQualityName {
    switch (this) {
      case 0:
        return '';
      case 1:
        return AppStrings.great.tr();
      case 2:
        return AppStrings.good.tr();
      case 3:
        return AppStrings.average.tr();
      case 4:
        return AppStrings.bad.tr();
      case 5:
        return AppStrings.veryBad.tr();
      case 6:
        return AppStrings.danger.tr();
      default:
        return '';
    }
  }

  Color? get toWaterQualityColor {
    switch (this) {
      case 1:
        return colorFromHexString("#0667CF");
      case 2:
        return colorFromHexString("#22A45D");
      case 3:
        return colorFromHexString("#39393F");
      case 4:
        return colorFromHexString("#FFC315");
      case 5:
        return colorFromHexString("#FF6B00");
      case 6:
        return colorFromHexString("#FF0F0F");
      default:
        return null;
    }
  }
}

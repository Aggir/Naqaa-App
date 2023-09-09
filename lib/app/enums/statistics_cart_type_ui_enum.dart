import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enums/statistics_date_enum.dart';
import 'package:naqaa/app/extensions.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';

enum StatisticsCardTypeUi {
  highest,
  lowest,
  average,
}

extension StatisticsCardTypeUiExtension on StatisticsCardTypeUi {
  bool get isHighest => this == StatisticsCardTypeUi.highest;
  bool get isLowest => this == StatisticsCardTypeUi.lowest;
  bool get isAverage => this == StatisticsCardTypeUi.average;

  Color get color {
    switch (this) {
      case StatisticsCardTypeUi.highest:
        return AppColors.red;
      case StatisticsCardTypeUi.lowest:
        return AppColors.green;
      case StatisticsCardTypeUi.average:
        return AppColors.primary;
    }
  }
}

extension IntToStatisticsCardTypeUi on int {
  String toStatisticsCardTypeUiTitle(StatisticsDate statisticsDate) {
    switch (statisticsDate) {
      case StatisticsDate.today:
        switch (this) {
          case 0:
            return '0 - 4';

          case 1:
            return '4 - 8';

          case 2:
            return '8 - 12';

          case 3:
            return '12 - 16';

          case 4:
            return '16 - 20';

          case 5:
            return '20 - 24';
          default:
            return '';
        }
      case StatisticsDate.sevenDays:
        final DateTime dateTimeNow = DateTime.now();
        switch (this) {
          case 0:
            return DateTime(
                    dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 6)
                .weekday
                .weekdayName;
          case 1:
            return DateTime(
                    dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 5)
                .weekday
                .weekdayName;
          case 2:
            return DateTime(
                    dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 4)
                .weekday
                .weekdayName;
          case 3:
            return DateTime(
                    dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 3)
                .weekday
                .weekdayName;
          case 4:
            return DateTime(
                    dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 2)
                .weekday
                .weekdayName;
          case 5:
            return DateTime(
                    dateTimeNow.year, dateTimeNow.month, dateTimeNow.day - 1)
                .weekday
                .weekdayName;

          case 6:
            return dateTimeNow.weekday.weekdayName;
          default:
            return '';
        }
      case StatisticsDate.month:
        switch (this) {
          case 0:
            return '${AppStrings.week.tr()} 1';
          case 1:
            return '${AppStrings.week.tr()} 2';
          case 2:
            return '${AppStrings.week.tr()} 3';
          case 3:
            return '${AppStrings.week.tr()} 4';
          case 4:
            return '${AppStrings.week.tr()} 5';
          case 5:
            return '${AppStrings.week.tr()} 6';
          default:
            return '';
        }
      case StatisticsDate.sixMonths:
        final DateTime dateTimeNow = DateTime.now();
        switch (this) {
          case 0:
            return '${AppStrings.month.tr()} ${dateTimeNow.month - 5}';
          case 1:
            return '${AppStrings.month.tr()} ${dateTimeNow.month - 4}';
          case 2:
            return '${AppStrings.month.tr()} ${dateTimeNow.month - 3}';
          case 3:
            return '${AppStrings.month.tr()} ${dateTimeNow.month - 2}';
          case 4:
            return '${AppStrings.month.tr()} ${dateTimeNow.month - 1}';
          case 5:
            return '${AppStrings.month.tr()} ${dateTimeNow.month}';
          default:
            return '';
        }
    }
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:naqaa/app/app_strings.dart';

enum StatisticsDate {
  today,
  sevenDays,
  month,
  sixMonths,
}

extension StatisticsDateExtension on StatisticsDate {
  bool get isToady => this == StatisticsDate.today;
  bool get isSevenDays => this == StatisticsDate.sevenDays;
  bool get isMonth => this == StatisticsDate.month;
  bool get isSixMonths => this == StatisticsDate.sixMonths;

  String name() {
    if (this == StatisticsDate.sevenDays) {
      return '7 ${AppStrings.days.tr()}';
    } else if (this == StatisticsDate.month) {
      return AppStrings.month.tr();
    } else if (this == StatisticsDate.sixMonths) {
      return '6 ${AppStrings.months.tr()}';
    } else {
      return AppStrings.today.tr();
    }
  }
}

extension StringToStatisticsDate on String {
  StatisticsDate toStatisticsDate() {
    final String sevenDays = StatisticsDate.sevenDays.index.toString();
    final String month = StatisticsDate.month.index.toString();
    final String sixMonths = StatisticsDate.sixMonths.index.toString();
    if (this == sevenDays) {
      return StatisticsDate.sevenDays;
    } else if (this == month) {
      return StatisticsDate.month;
    } else if (this == sixMonths) {
      return StatisticsDate.sixMonths;
    } else {
      return StatisticsDate.today;
    }
  }
}

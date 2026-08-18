import 'package:equatable/equatable.dart';

import 'package:naqaa/app/constants.dart';

class StatisticEntity extends Equatable {
  final int tempHighest;
  final int tempLowest;
  final double tempAverage;
  final int tdsHighest;
  final int tdsLowest;
  final double tdsAverage;
  final double phHighest;
  final double phLowest;
  final double phAverage;
  final int waterQuality;

  const StatisticEntity({
    required this.tempHighest,
    required this.tempLowest,
    required this.tempAverage,
    required this.tdsHighest,
    required this.tdsLowest,
    required this.tdsAverage,
    required this.phHighest,
    required this.phLowest,
    required this.phAverage,
    required this.waterQuality,
  });

  factory StatisticEntity.empty() => const StatisticEntity(
        tempHighest: Constants.zero,
        tempLowest: Constants.zero,
        tempAverage: Constants.dZero,
        tdsHighest: Constants.zero,
        tdsLowest: Constants.zero,
        tdsAverage: Constants.dZero,
        phHighest: Constants.dZero,
        phLowest: Constants.dZero,
        phAverage: Constants.dZero,
        waterQuality: Constants.zero,
      );

  @override
  List<Object> get props {
    return [
      tempHighest,
      tempLowest,
      tempAverage,
      tdsHighest,
      tdsLowest,
      tdsAverage,
      phHighest,
      phLowest,
      phAverage,
      waterQuality,
    ];
  }

  @override
  String toString() {
    return 'StatisticEntity(tempHighest: $tempHighest, tempLowest: $tempLowest, tempAverage: $tempAverage, tdsHighest: $tdsHighest, tdsLowest: $tdsLowest, tdsAverage: $tdsAverage, phHighest: $phHighest, phLowest: $phLowest, phAverage: $phAverage, waterQuality: $waterQuality)';
  }
}

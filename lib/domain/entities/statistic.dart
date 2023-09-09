import 'package:equatable/equatable.dart';

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
  final String waterQualityName;
  final String waterQualityHex;

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
    required this.waterQualityName,
    required this.waterQualityHex,
  });

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
      waterQualityName,
      waterQualityHex,
    ];
  }
}

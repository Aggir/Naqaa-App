import 'package:naqaa/data/datasources/remote/firebase_constants.dart';

class StatisticModel {
  final int? tempHighest;
  final int? tempLowest;
  final double? tempAverage;
  final int? tdsHighest;
  final int? tdsLowest;
  final double? tdsAverage;
  final double? phHighest;
  final double? phLowest;
  final double? phAverage;
  final int? waterQuality;

  const StatisticModel({
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

  factory StatisticModel.fromMap(Map<dynamic, dynamic> map) {
    return StatisticModel(
      tempHighest: map[FirebaseConstants.tempHighest]?.toInt(),
      tempLowest: map[FirebaseConstants.tempLowest]?.toInt(),
      tempAverage: map[FirebaseConstants.tempAverage]?.toDouble(),
      tdsHighest: map[FirebaseConstants.tdsHighest]?.toInt(),
      tdsLowest: map[FirebaseConstants.tdsLowest]?.toInt(),
      tdsAverage: map[FirebaseConstants.tdsAverage]?.toDouble(),
      phHighest: map[FirebaseConstants.phHighest]?.toDouble(),
      phLowest: map[FirebaseConstants.phLowest]?.toDouble(),
      phAverage: map[FirebaseConstants.phAverage]?.toDouble(),
      waterQuality: map[FirebaseConstants.waterQuality]?.toInt(),
    );
  }
}

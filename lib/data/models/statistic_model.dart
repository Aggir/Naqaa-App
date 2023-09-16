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
      tempAverage: map[FirebaseConstants.tempAverage] != null
          ? double.parse(map[FirebaseConstants.tempAverage])
          : null,
      tdsHighest: map[FirebaseConstants.tdsHighest]?.toInt(),
      tdsLowest: map[FirebaseConstants.tdsLowest]?.toInt(),
      tdsAverage: map[FirebaseConstants.tdsAverage] != null
          ? double.parse(map[FirebaseConstants.tdsAverage])
          : null,
      phHighest: map[FirebaseConstants.phHighest] != null
          ? double.parse(map[FirebaseConstants.phHighest])
          : null,
      phLowest: map[FirebaseConstants.phLowest] != null
          ? double.parse(map[FirebaseConstants.phLowest])
          : null,
      phAverage: map[FirebaseConstants.phAverage] != null
          ? double.parse(map[FirebaseConstants.phAverage])
          : null,
      waterQuality: map[FirebaseConstants.waterQuality]?.toInt(),
    );
  }
}

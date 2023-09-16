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
      tempHighest: map[FirebaseConstants.tempHighest],
      tempLowest: map[FirebaseConstants.tempLowest],
      tempAverage: map[FirebaseConstants.tempAverage] != null
          ? map[FirebaseConstants.tempAverage] is String
              ? double.parse(map[FirebaseConstants.tempAverage])
              : map[FirebaseConstants.tempAverage].toDouble()
          : null,
      tdsHighest: map[FirebaseConstants.tdsHighest],
      tdsLowest: map[FirebaseConstants.tdsLowest],
      tdsAverage: map[FirebaseConstants.tdsAverage] != null
          ? map[FirebaseConstants.tdsAverage] is String
              ? double.parse(map[FirebaseConstants.tdsAverage])
              : map[FirebaseConstants.tdsAverage].toDouble()
          : null,
      phHighest: map[FirebaseConstants.phHighest] != null
          ? map[FirebaseConstants.phHighest] is String
              ? double.parse(map[FirebaseConstants.phHighest])
              : map[FirebaseConstants.phHighest].toDouble()
          : null,
      phLowest: map[FirebaseConstants.phLowest] != null
          ? map[FirebaseConstants.phLowest] is String
              ? double.parse(map[FirebaseConstants.phLowest])
              : map[FirebaseConstants.phLowest].toDouble()
          : null,
      phAverage: map[FirebaseConstants.phAverage] != null
          ? map[FirebaseConstants.phAverage] is String
              ? double.parse(map[FirebaseConstants.phAverage])
              : map[FirebaseConstants.phAverage].toDouble()
          : null,
      waterQuality: map[FirebaseConstants.waterQuality],
    );
  }
}

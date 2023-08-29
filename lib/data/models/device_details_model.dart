import 'package:naqaa/data/datasources/remote/firebase_constants.dart';

class DeviceDetailsModel {
  final double? phValue;
  final double? phMin;
  final double? phMax;
  final double? tdsValue;
  final double? tdsMin;
  final double? tdsMax;
  final double? tempValue;
  final double? tempMin;
  final double? tempMax;
  final int? updatedAt;

  DeviceDetailsModel({
    required this.phValue,
    required this.phMin,
    required this.phMax,
    required this.tdsValue,
    required this.tdsMin,
    required this.tdsMax,
    required this.tempValue,
    required this.tempMin,
    required this.tempMax,
    required this.updatedAt,
  });

  factory DeviceDetailsModel.fromMap(Map<dynamic, dynamic>? map) {
    return DeviceDetailsModel(
      phValue: map?[FirebaseConstants.phValue].toDouble(),
      phMin: map?[FirebaseConstants.phMin].toDouble(),
      phMax: map?[FirebaseConstants.phMax].toDouble(),
      tdsValue: map?[FirebaseConstants.tdsValue].toDouble(),
      tdsMin: map?[FirebaseConstants.tdsMin].toDouble(),
      tdsMax: map?[FirebaseConstants.tdsMax].toDouble(),
      tempValue: map?[FirebaseConstants.tempValue].toDouble(),
      tempMin: map?[FirebaseConstants.tempMin].toDouble(),
      tempMax: map?[FirebaseConstants.tempMax].toDouble(),
      updatedAt: map?[FirebaseConstants.updatedAt],
    );
  }

  @override
  String toString() {
    return 'DeviceDetailsModel(phValue: $phValue, phMin: $phMin, phMax: $phMax, tdsValue: $tdsValue, tdsMin: $tdsMin, tdsMax: $tdsMax, tempValue: $tempValue, tempMin: $tempMin, tempMax: $tempMax, updatedAt: $updatedAt)';
  }
}

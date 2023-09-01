import 'package:naqaa/data/datasources/remote/firebase_constants.dart';

class DeviceModel {
  final String? id;
  final String? userId;
  final String? name;
  final String? waterQualityName;
  final String? waterQualityHex;
  DeviceModel({
    this.id,
    this.userId,
    this.name,
    this.waterQualityName,
    this.waterQualityHex,
  });

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      id: map[FirebaseConstants.id],
      userId: map[FirebaseConstants.userId],
      name: map[FirebaseConstants.name],
      waterQualityName: map[FirebaseConstants.waterQualityName],
      waterQualityHex: map[FirebaseConstants.waterQualityHex],
    );
  }
}

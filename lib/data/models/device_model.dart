import 'package:naqaa/data/datasources/remote/firebase_constants.dart';

class DeviceModel {
  final String? name;
  final String? macAddress;
  final String? waterQualityName;
  final String? waterQualityHex;
  DeviceModel({
    this.name,
    this.macAddress,
    this.waterQualityName,
    this.waterQualityHex,
  });

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      name: map[FirebaseConstants.name],
      macAddress: map[FirebaseConstants.macAddress],
      waterQualityName: map[FirebaseConstants.waterQualityName],
      waterQualityHex: map[FirebaseConstants.waterQualityHex],
    );
  }
}

import 'package:naqaa/data/datasources/remote/firebase_constants.dart';

class DeviceModel {
  final String? name;
  final String? macAddress;
  final String? waterQuality;
  final String? hexColor;
  DeviceModel({
    this.name,
    this.macAddress,
    this.waterQuality,
    this.hexColor,
  });

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      name: map[FirebaseConstants.name],
      macAddress: map[FirebaseConstants.macAddress],
      waterQuality: map[FirebaseConstants.waterQuality],
      hexColor: map[FirebaseConstants.hexColor],
    );
  }
}

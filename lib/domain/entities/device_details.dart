import 'package:equatable/equatable.dart';
import 'package:naqaa/app/constants.dart';

class DeviceDetailsEntity extends Equatable {
  final double phValue;
  final double phMin;
  final double phMax;
  final double tdsValue;
  final double tdsMin;
  final double tdsMax;
  final double tempValue;
  final double tempMin;
  final double tempMax;
  final bool isConnected;

  const DeviceDetailsEntity({
    required this.phValue,
    required this.phMin,
    required this.phMax,
    required this.tdsValue,
    required this.tdsMin,
    required this.tdsMax,
    required this.tempValue,
    required this.tempMin,
    required this.tempMax,
    required this.isConnected,
  });

  factory DeviceDetailsEntity.empty() => const DeviceDetailsEntity(
      phValue: Constants.dZero,
      phMin: Constants.dZero,
      phMax: Constants.dZero,
      tdsValue: Constants.dZero,
      tdsMin: Constants.dZero,
      tdsMax: Constants.dZero,
      tempValue: Constants.dZero,
      tempMin: Constants.dZero,
      tempMax: Constants.dZero,
      isConnected: false);

  @override
  List<Object> get props {
    return [
      phValue,
      phMin,
      phMax,
      tdsValue,
      tdsMin,
      tdsMax,
      tempValue,
      tempMin,
      tempMax,
      isConnected,
    ];
  }
}

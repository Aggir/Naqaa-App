import 'package:equatable/equatable.dart';
import 'package:naqaa/app/constants.dart';

class DeviceEntity extends Equatable {
  final String id;
  final String name;
  final String waterQuality;
  final String hexColor;
  const DeviceEntity({
    required this.name,
    required this.id,
    required this.waterQuality,
    required this.hexColor,
  });

  factory DeviceEntity.empty() => const DeviceEntity(
        name: Constants.empty,
        id: Constants.empty,
        waterQuality: Constants.empty,
        hexColor: Constants.empty,
      );

  @override
  List<Object> get props => [
        name,
        id,
        waterQuality,
        hexColor,
      ];
}

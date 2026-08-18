import 'package:equatable/equatable.dart';
import 'package:naqaa/app/enums/sensor_type_enum.dart';

class SensorDetails extends Equatable {
  final double min;
  final double max;
  final double value;
  final SensorType type;

  const SensorDetails({
    required this.min,
    required this.max,
    required this.value,
    required this.type,
  });

  @override
  List<Object> get props {
    return [
      min,
      max,
      value,
      type,
    ];
  }
}

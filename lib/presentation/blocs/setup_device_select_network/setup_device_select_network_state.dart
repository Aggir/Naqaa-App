part of 'setup_device_select_network_cubit.dart';

class SetupDeviceSelectNetworkState extends Equatable {
  final List<WiFiAccessPoint>? accessPoints;

  const SetupDeviceSelectNetworkState({
    this.accessPoints,
  });
  @override
  List<Object?> get props => [accessPoints];

  SetupDeviceSelectNetworkState copyWith({
    List<WiFiAccessPoint>? accessPoints,
  }) {
    return SetupDeviceSelectNetworkState(
      accessPoints: accessPoints ?? this.accessPoints,
    );
  }
}

part of 'setup_device_select_network_cubit.dart';

class SetupDeviceSelectNetworkState extends Equatable {
  final List<WiFiAccessPoint>? accessPoints;
  final String? bssid;
  final Status connectStatus;
  final String? connectErrorMessage;

  const SetupDeviceSelectNetworkState({
    this.accessPoints,
    this.bssid,
    this.connectStatus = Status.initial,
    this.connectErrorMessage,
  });
  @override
  List<Object?> get props => [
        accessPoints,
        bssid,
        connectStatus,
      ];

  SetupDeviceSelectNetworkState copyWith({
    List<WiFiAccessPoint>? accessPoints,
    String? bssid,
    Status? connectStatus,
    String? connectErrorMessage,
  }) {
    return SetupDeviceSelectNetworkState(
      accessPoints: accessPoints ?? this.accessPoints,
      bssid: bssid ?? this.bssid,
      connectStatus: connectStatus ?? this.connectStatus,
      connectErrorMessage: connectErrorMessage ?? this.connectErrorMessage,
    );
  }
}

part of 'setup_device_cubit.dart';

class SetupDeviceState extends Equatable {
  final List<WiFiAccessPoint>? accessPoints;
  final String? bssid;
  final Status connectStatus;
  final String? connectErrorMessage;
  final Status addDeviceStatus;
  final String? addDeviceErrorMessage;
  final PermissionStatus? locationPermissionStatus;
  final ServiceStatus? locationServiceStatus;

  const SetupDeviceState({
    this.accessPoints,
    this.bssid,
    this.connectStatus = Status.initial,
    this.connectErrorMessage,
    this.addDeviceStatus = Status.initial,
    this.addDeviceErrorMessage,
    this.locationPermissionStatus,
    this.locationServiceStatus,
  });
  @override
  List<Object?> get props => [
        accessPoints,
        bssid,
        connectStatus,
        addDeviceStatus,
        addDeviceErrorMessage,
        locationPermissionStatus,
        locationServiceStatus
      ];

  SetupDeviceState copyWith({
    List<WiFiAccessPoint>? accessPoints,
    String? bssid,
    Status? connectStatus,
    String? connectErrorMessage,
    Status? addDeviceStatus,
    String? addDeviceErrorMessage,
    PermissionStatus? locationPermissionStatus,
    ServiceStatus? locationServiceStatus,
  }) {
    return SetupDeviceState(
      accessPoints: accessPoints ?? this.accessPoints,
      bssid: bssid ?? this.bssid,
      connectStatus: connectStatus ?? this.connectStatus,
      connectErrorMessage: connectErrorMessage ?? this.connectErrorMessage,
      addDeviceStatus: addDeviceStatus ?? this.addDeviceStatus,
      addDeviceErrorMessage:
          addDeviceErrorMessage ?? this.addDeviceErrorMessage,
      locationPermissionStatus:
          locationPermissionStatus ?? this.locationPermissionStatus,
      locationServiceStatus: locationServiceStatus ?? this.locationServiceStatus,
    );
  }
}

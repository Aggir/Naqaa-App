part of 'devices_cubit.dart';

class DevicesState extends Equatable {
  final Status fetchDevicesStatus;
  final String? fetchDevicesErrorMessage;
  final Stream<List<DeviceEntity>>? devicesStream;
  final DeviceEntity? selectedDevice;
  final bool isEditing;
  final Status editDeviceNameStatus;
  final String? editDeviceNameErrorMessage;
  final Status deviceDetailsStatus;
  final String? deviceDetailsErrorMessage;
  final Stream<DeviceDetailsEntity>? deviceDetailsStream;
  final SensorDetails? selectedSensor;

  const DevicesState({
    this.fetchDevicesStatus = Status.initial,
    this.fetchDevicesErrorMessage,
    this.devicesStream,
    this.selectedDevice,
    this.isEditing = false,
    this.editDeviceNameStatus = Status.initial,
    this.editDeviceNameErrorMessage,
    this.deviceDetailsStatus = Status.initial,
    this.deviceDetailsErrorMessage,
    this.deviceDetailsStream,
    this.selectedSensor,
  });

  @override
  List<Object?> get props => [
        fetchDevicesStatus,
        fetchDevicesErrorMessage,
        devicesStream,
        selectedDevice,
        isEditing,
        editDeviceNameStatus,
        editDeviceNameErrorMessage,
        deviceDetailsStatus,
        deviceDetailsErrorMessage,
        deviceDetailsStream,
        selectedSensor,
      ];

  DevicesState copyWith({
    Status? fetchDevicesStatus,
    String? fetchDevicesErrorMessage,
    Stream<List<DeviceEntity>>? devicesStream,
    DeviceEntity? selectedDevice,
    bool? isEditing,
    Status? editDeviceNameStatus,
    String? editDeviceNameErrorMessage,
    Status? deviceDetailsStatus,
    String? deviceDetailsErrorMessage,
    Stream<DeviceDetailsEntity>? deviceDetailsStream,
    SensorDetails? selectedSensor,
  }) {
    return DevicesState(
        fetchDevicesStatus: fetchDevicesStatus ?? this.fetchDevicesStatus,
        fetchDevicesErrorMessage:
            fetchDevicesErrorMessage ?? this.fetchDevicesErrorMessage,
        devicesStream: devicesStream ?? this.devicesStream,
        selectedDevice: selectedDevice ?? this.selectedDevice,
        isEditing: isEditing ?? this.isEditing,
        editDeviceNameStatus: editDeviceNameStatus ?? this.editDeviceNameStatus,
        editDeviceNameErrorMessage:
            editDeviceNameErrorMessage ?? this.editDeviceNameErrorMessage,
        deviceDetailsStatus: deviceDetailsStatus ?? this.deviceDetailsStatus,
        deviceDetailsErrorMessage:
            deviceDetailsErrorMessage ?? this.deviceDetailsErrorMessage,
        deviceDetailsStream: deviceDetailsStream ?? this.deviceDetailsStream,
        selectedSensor: selectedSensor ?? this.selectedSensor);
  }
}

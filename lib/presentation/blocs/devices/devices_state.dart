part of 'devices_cubit.dart';

class DevicesState extends Equatable {
  final Status fetchDevicesStatus;
  final String? fetchDevicesErrorMessage;
  final Stream<List<DeviceEntity>>? devicesStream;
  final List<DeviceEntity>? latestDevicesSnapshot;
  final DeviceEntity? selectedDevice;
  final bool isEditing;
  final Status editDeviceNameStatus;
  final String? editDeviceNameErrorMessage;
  final Status deviceDetailsStatus;
  final String? deviceDetailsErrorMessage;
  final Stream<DeviceDetailsEntity>? deviceDetailsStream;
  final SensorDetails? selectedSensor;
  final Status deleteDeviceStatus;
  final String? deleteDeviceErrorMessage;

  const DevicesState({
    this.fetchDevicesStatus = Status.initial,
    this.fetchDevicesErrorMessage,
    this.devicesStream,
    this.latestDevicesSnapshot,
    this.selectedDevice,
    this.isEditing = false,
    this.editDeviceNameStatus = Status.initial,
    this.editDeviceNameErrorMessage,
    this.deviceDetailsStatus = Status.initial,
    this.deviceDetailsErrorMessage,
    this.deviceDetailsStream,
    this.selectedSensor,
    this.deleteDeviceStatus = Status.initial,
    this.deleteDeviceErrorMessage,
  });

  @override
  List<Object?> get props => [
        fetchDevicesStatus,
        fetchDevicesErrorMessage,
        devicesStream,
        latestDevicesSnapshot,
        selectedDevice,
        isEditing,
        editDeviceNameStatus,
        editDeviceNameErrorMessage,
        deviceDetailsStatus,
        deviceDetailsErrorMessage,
        deviceDetailsStream,
        selectedSensor,
        deleteDeviceStatus,
        deleteDeviceErrorMessage,
      ];

  DevicesState copyWith({
    Status? fetchDevicesStatus,
    String? fetchDevicesErrorMessage,
    Stream<List<DeviceEntity>>? devicesStream,
    List<DeviceEntity>? latestDevicesSnapshot,
    DeviceEntity? selectedDevice,
    bool? isEditing,
    Status? editDeviceNameStatus,
    String? editDeviceNameErrorMessage,
    Status? deviceDetailsStatus,
    String? deviceDetailsErrorMessage,
    Stream<DeviceDetailsEntity>? deviceDetailsStream,
    SensorDetails? selectedSensor,
    Status? deleteDeviceStatus,
    String? deleteDeviceErrorMessage,
  }) {
    return DevicesState(
      fetchDevicesStatus: fetchDevicesStatus ?? this.fetchDevicesStatus,
      fetchDevicesErrorMessage:
          fetchDevicesErrorMessage ?? this.fetchDevicesErrorMessage,
      devicesStream: devicesStream ?? this.devicesStream,
      latestDevicesSnapshot:
          latestDevicesSnapshot ?? this.latestDevicesSnapshot,
      selectedDevice: selectedDevice ?? this.selectedDevice,
      isEditing: isEditing ?? this.isEditing,
      editDeviceNameStatus: editDeviceNameStatus ?? this.editDeviceNameStatus,
      editDeviceNameErrorMessage:
          editDeviceNameErrorMessage ?? this.editDeviceNameErrorMessage,
      deviceDetailsStatus: deviceDetailsStatus ?? this.deviceDetailsStatus,
      deviceDetailsErrorMessage:
          deviceDetailsErrorMessage ?? this.deviceDetailsErrorMessage,
      deviceDetailsStream: deviceDetailsStream ?? this.deviceDetailsStream,
      selectedSensor: selectedSensor ?? this.selectedSensor,
      deleteDeviceStatus: deleteDeviceStatus ?? this.deleteDeviceStatus,
      deleteDeviceErrorMessage:
          deleteDeviceErrorMessage ?? this.deleteDeviceErrorMessage,
    );
  }
}

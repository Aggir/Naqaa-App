part of 'devices_cubit.dart';

class DevicesState extends Equatable {
  final Status fetchDevicesStatus;
  final String? fetchDevicesErrorMessage;
  final Stream<List<DeviceEntity>>? devicesStream;
  final DeviceEntity? selectedDevice;
  final bool isEditing;
  final Status editDeviceNameStatus;
  final String? editDeviceNameErrorMessage;

  const DevicesState({
    this.fetchDevicesStatus = Status.initial,
    this.fetchDevicesErrorMessage,
    this.devicesStream,
    this.selectedDevice,
    this.isEditing = false,
    this.editDeviceNameStatus = Status.initial,
    this.editDeviceNameErrorMessage,
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
      ];

  DevicesState copyWith({
    Status? fetchDevicesStatus,
    String? fetchDevicesErrorMessage,
    Stream<List<DeviceEntity>>? devicesStream,
    DeviceEntity? selectedDevice,
    bool? isEditing,
    Status? editDeviceNameStatus,
    String? editDeviceNameErrorMessage,
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
    );
  }
}

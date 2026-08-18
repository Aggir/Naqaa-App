import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/enums/sensor_type_enum.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/domain/data_classes/sensor_details.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/domain/entities/device_details.dart';
import 'package:naqaa/domain/usecases/delete_device_usecase.dart';
import 'package:naqaa/domain/usecases/edit_device_name_usecase.dart';
import 'package:naqaa/domain/usecases/get_device_details_usecase.dart';
import 'package:naqaa/domain/usecases/get_devices_usecase.dart';

part 'devices_state.dart';

class DevicesCubit extends Cubit<DevicesState> {
  DevicesCubit() : super(const DevicesState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  StreamSubscription<List<DeviceEntity>>? _devicesSubscription;
  getDevices() async {
    emit(state.copyWith(fetchDevicesStatus: Status.loading));
    initGetDevices();
    (await instance<GetDevicesUsecase>().execute(null)).fold(
        (failure) => emit(state.copyWith(
            fetchDevicesStatus: Status.failure,
            fetchDevicesErrorMessage: failure.message)),
        (stream) => emit(state.copyWith(
            fetchDevicesStatus: Status.success, devicesStream: stream)));

    _devicesSubscription = state.devicesStream?.listen((devices) {
      if (state.selectedDevice != null && devices.isNotEmpty) {
        final newSelectedDevice = devices.firstWhere(
          (device) => state.selectedDevice?.id == device.id,
        );
        emit(state.copyWith(
          latestDevicesSnapshot: devices,
          selectedDevice: newSelectedDevice,
        ));
      } else {
        emit(state.copyWith(latestDevicesSnapshot: devices));
      }
    });
  }

  selectSensor(SensorType sensorType, DeviceDetailsEntity deviceDetails) {
    switch (sensorType) {
      case SensorType.temp:
        emit(state.copyWith(
            selectedSensor: SensorDetails(
                min: deviceDetails.tempMin,
                max: deviceDetails.tempMax,
                value: deviceDetails.tempValue,
                type: sensorType)));
      case SensorType.tds:
        emit(state.copyWith(
            selectedSensor: SensorDetails(
                min: deviceDetails.tdsMin,
                max: deviceDetails.tdsMax,
                value: deviceDetails.tdsValue,
                type: sensorType)));
      case SensorType.ph:
        emit(state.copyWith(
            selectedSensor: SensorDetails(
                min: deviceDetails.phMin,
                max: deviceDetails.phMax,
                value: deviceDetails.phValue,
                type: sensorType)));
    }
  }

  deviceDetails(DeviceEntity device) async {
    emit(state.copyWith(
      selectedDevice: device,
      deviceDetailsStatus: Status.loading,
    ));
    initGetDeviceDetails();
    (await instance<GetDeviceDetailsUsecase>().execute(device.id)).fold(
        (failure) => emit(state.copyWith(
            deviceDetailsStatus: Status.failure,
            deviceDetailsErrorMessage: failure.message)),
        (stream) => emit(state.copyWith(
            deviceDetailsStatus: Status.success, deviceDetailsStream: stream)));
  }

  saveEdit() async {
    if (formKey.currentState?.validate() ?? false) {
      if (state.selectedDevice?.name == nameController.text.trim()) {
        emit(state.copyWith(isEditing: false));
      } else {
        emit(state.copyWith(editDeviceNameStatus: Status.loading));
        initEditDeviceName();
        (await instance<EditDeviceNameUsecase>().execute(
                EditDeviceNameUsecaseInput(
                    newName: nameController.text.trim(),
                    macAddress: state.selectedDevice!.id)))
            .fold(
                (failure) => emit(state.copyWith(
                    editDeviceNameStatus: Status.failure,
                    editDeviceNameErrorMessage: failure.message)),
                (r) => emit(state.copyWith(
                    editDeviceNameStatus: Status.success, isEditing: false)));
      }
    }
  }

  toggleEdit(DeviceEntity device) {
    nameController.text = device.name;
    emit(state.copyWith(isEditing: true, selectedDevice: device));
  }

  deleteDevice() async {
    emit(state.copyWith(deleteDeviceStatus: Status.loading));
    initDeleteDevice();
    emit(state.copyWith(deleteDeviceStatus: Status.success, isEditing: false));
    (await instance<DeleteDeviceUsecase>().execute(state.selectedDevice!.id))
        .fold(
            (failure) => emit(state.copyWith(
                deleteDeviceStatus: Status.failure,
                deleteDeviceErrorMessage: failure.message)),
            (_) => emit(state.copyWith(
                  deleteDeviceStatus: Status.success,
                  isEditing: false,
                )));
  }

  @override
  Future<void> close() {
    _devicesSubscription?.cancel();
    return super.close();
  }
}

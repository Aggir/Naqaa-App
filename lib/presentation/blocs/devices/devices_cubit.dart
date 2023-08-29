import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/domain/usecases/edit_device_name_usecase.dart';
import 'package:naqaa/domain/usecases/get_devices_usecase.dart';

part 'devices_state.dart';

class DevicesCubit extends Cubit<DevicesState> {
  DevicesCubit() : super(const DevicesState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  getDevices() async {
    emit(state.copyWith(fetchDevicesStatus: Status.loading));
    initGetDevices();
    (await instance<GetDevicesUsecase>().execute(null)).fold(
        (failure) => emit(state.copyWith(
            fetchDevicesStatus: Status.failure,
            fetchDevicesErrorMessage: failure.message)),
        (stream) => emit(state.copyWith(
            fetchDevicesStatus: Status.success, devicesStream: stream)));
  }

  selectDevice(DeviceEntity device) {
    emit(state.copyWith(selectedDevice: device));
  }

  saveEdit() async {
    if (formKey.currentState?.validate() ?? false) {
      emit(state.copyWith(editDeviceNameStatus: Status.loading));
      initEditDeviceName();
      (await instance<EditDeviceNameUsecase>().execute(
              EditDeviceNameUsecaseInput(
                  newName: nameController.text,
                  macAddress: state.selectedDevice!.macAddress)))
          .fold(
              (failure) => emit(state.copyWith(
                  editDeviceNameStatus: Status.failure,
                  editDeviceNameErrorMessage: failure.message)),
              (r) => emit(state.copyWith(
                  editDeviceNameStatus: Status.success, isEditing: false)));
    }
  }

  toggleEdit(DeviceEntity device) {
    nameController.text = device.name;
    emit(state.copyWith(isEditing: true, selectedDevice: device));
  }
}

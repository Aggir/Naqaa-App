import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/domain/usecases/add_device_usecase.dart';
import 'package:wifi_scan/wifi_scan.dart';

part 'setup_device_state.dart';

class SetupDeviceCubit extends Cubit<SetupDeviceState> {
  SetupDeviceCubit() : super(const SetupDeviceState());
  bool debugMode = false;
  final GlobalKey<FormState> networkDataForm = GlobalKey<FormState>();
  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final GlobalKey<FormState> deviceNameForm = GlobalKey<FormState>();
  final TextEditingController deviceNameController = TextEditingController();
  final FocusNode deviceNameFocusNode = FocusNode();

  final GlobalKey<FormState> deviceMacForm = GlobalKey<FormState>();
  final TextEditingController deviceMacController = TextEditingController();

  final WiFiScan _wiFiScan = instance<WiFiScan>();

  StreamSubscription<List<WiFiAccessPoint>>? subscription;

  Future<bool> _canGetScannedResults() async {
    final can = await _wiFiScan.canGetScannedResults(askPermissions: true);
    if (can != CanGetScannedResults.yes) {
      return false;
    }
    return true;
  }

  Future<void> addDevice() async {
    emit(state.copyWith(addDeviceStatus: Status.loading));
    initAddDevice();
    (await instance<AddDeviceUsecase>().execute(AddDeviceUsecaseInput(
            name: deviceNameController.text.trim(),
            macAddress: deviceMacController.text.trim())))
        .fold(
            (failure) => emit(state.copyWith(
                addDeviceStatus: Status.failure,
                addDeviceErrorMessage: failure.message)),
            (_) => emit(state.copyWith(addDeviceStatus: Status.success)));
  }

  Future<void> startListeningToScanResults() async {
    if (await _canGetScannedResults()) {
      subscription = _wiFiScan.onScannedResultsAvailable.listen(
        (result) {
          emit(
            state.copyWith(
              accessPoints: result
                ..sort(
                  (a, b) => b.level.compareTo(a.level),
                ),
            ),
          );
        },
      );
    }
  }

  refresh() async {
    if (await _canGetScannedResults()) {
      await _wiFiScan.startScan();
      final result = await _wiFiScan.getScannedResults();
      emit(
        state.copyWith(
          accessPoints: result
            ..sort(
              (a, b) => b.level.compareTo(a.level),
            ),
        ),
      );
    }
  }

  void selectNetwork(String bssid) {
    emit(state.copyWith(bssid: bssid));
  }

  // TODO: Remove 'debugMode' and prints
  void connect() async {
    if (networkDataForm.currentState?.validate() ?? false) {
      print(ssidController.text);
      print(state.bssid);
      print(passwordController.text);

      emit(state.copyWith(connectStatus: Status.loading));
      final provisioner = Provisioner.espTouch();
      provisioner.listen((response) {
        if (response.bssidText.isNotEmpty) {
          deviceMacController.text = response.bssidText;
        }
        emit(state.copyWith(connectStatus: Status.success));
      });

      try {
        await provisioner.start(ProvisioningRequest.fromStrings(
          ssid: ssidController.text,
          bssid: state.bssid!,
          password: passwordController.text,
        ));
        await Future.delayed(Duration(seconds: debugMode ? 2 : 20));
      } catch (e) {
        emit(state.copyWith(
            connectStatus: Status.failure, connectErrorMessage: e.toString()));
      }
      provisioner.stop();
      if (debugMode) {
        deviceMacController.text = 'D4:D4:DA:71:D6:F8';
      }
      emit(
        state.copyWith(
            connectStatus: debugMode ? Status.success : Status.failure,
            connectErrorMessage: AppStrings.connectErrorMessage.tr()),
      );
    }
  }

  void stopListeningToScanResults() {
    subscription?.cancel();
    subscription = null;
  }

  @override
  Future<void> close() {
    stopListeningToScanResults();
    return super.close();
  }
}

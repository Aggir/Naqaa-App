import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/enum.dart';
import 'package:wifi_scan/wifi_scan.dart';

part 'setup_device_select_network_state.dart';

class SetupDeviceSelectNetworkCubit
    extends Cubit<SetupDeviceSelectNetworkState> {
  SetupDeviceSelectNetworkCubit()
      : super(const SetupDeviceSelectNetworkState());

  final GlobalKey<FormState> networkDataForm = GlobalKey<FormState>();
  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final GlobalKey<FormState> deviceNameForm = GlobalKey<FormState>();
  final TextEditingController deviceNameController = TextEditingController();

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

  void connect() async {
    if (networkDataForm.currentState?.validate() ?? false) {
      print(ssidController.text);
      print(state.bssid);
      print(passwordController.text);
      // TODO: REFACTOR STATUS FLOW.
      // make it wait for 10 seconds and if there is no response from any device, the emit Status failure
      // emit Status failure if the credentials are invalid
      emit(state.copyWith(connectStatus: Status.loading));
      final provisioner = Provisioner.espTouch();
      provisioner.listen((response) {
        print("Device ${response.bssidText} connected to WiFi!");
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
        await Future.delayed(const Duration(seconds: 10));
      } catch (e) {
        emit(state.copyWith(
            connectStatus: Status.failure, connectErrorMessage: e.toString()));
      }
      provisioner.stop();
      emit(
        state.copyWith(
            connectStatus: Status.failure,
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

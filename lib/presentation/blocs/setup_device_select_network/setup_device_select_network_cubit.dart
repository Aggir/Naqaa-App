import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:wifi_scan/wifi_scan.dart';

part 'setup_device_select_network_state.dart';

class SetupDeviceSelectNetworkCubit
    extends Cubit<SetupDeviceSelectNetworkState> {
  SetupDeviceSelectNetworkCubit()
      : super(const SetupDeviceSelectNetworkState());

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

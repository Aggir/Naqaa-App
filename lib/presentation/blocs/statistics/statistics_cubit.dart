import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/enums/sensor_type_enum.dart';
import 'package:naqaa/app/enums/statistics_date_enum.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/domain/entities/statistic.dart';
import 'package:naqaa/domain/usecases/get_statistics_usecase.dart';

part 'statistics_state.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  StatisticsCubit() : super(const StatisticsState());

  init(List<DeviceEntity> list) {
    emit(
      state.copyWith(
        selectedSensorType: SensorType.temp,
        selectedDeviceId: list[0].id,
        selectedPeriodIndex: state.statistics?.length ?? 0,
        selectedStatisticsDate: StatisticsDate.today,
      ),
    );
    getStatistics();
  }

  void selectSensorType(String sensorTypeString) {
    SensorType sensorType = sensorTypeString.toSensorType();
    print(sensorType);
    emit(state.copyWith(selectedSensorType: sensorType));
  }

  void selectStatisticsDate(StatisticsDate statisticsDate) {
    emit(state.copyWith(
        selectedStatisticsDate: statisticsDate, selectedPeriodIndex: 0));
    getStatistics();
  }

  void selectedPeriodIndex(int periodIndex) {
    emit(state.copyWith(selectedPeriodIndex: periodIndex));
  }

  void selectDevice(String deviceId) {
    print(deviceId);
    emit(state.copyWith(selectedDeviceId: deviceId));
  }

  Future<void> getStatistics() async {
    emit(state.copyWith(getStatisticsStatus: Status.loading));
    initGetStatistics();
    (await instance<GetStatisticsUsecase>().execute(GetStatisticsUsecaseInput(
            statisticsDate: state.selectedStatisticsDate,
            deviceId: state.selectedDeviceId!)))
        .fold(
            (failure) => emit(state.copyWith(
                getStatisticsStatus: Status.failure,
                getStatisticsErrorMessage: failure.message)),
            (statistics) => emit(state.copyWith(
                getStatisticsStatus: Status.success,
                statistics: statistics,
                selectedPeriodIndex: statistics.length - 1)));
  }
}

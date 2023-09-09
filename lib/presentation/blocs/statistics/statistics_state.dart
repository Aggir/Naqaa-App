part of 'statistics_cubit.dart';

class StatisticsState extends Equatable {
  final String? selectedDeviceId;
  final SensorType selectedSensorType;
  final StatisticsDate selectedStatisticsDate;
  final Status getStatisticsStatus;
  final String? getStatisticsErrorMessage;
  final List<StatisticEntity>? statistics;
  final int? selectedPeriodIndex;
  const StatisticsState(
      {this.selectedDeviceId,
      this.selectedSensorType = SensorType.temp,
      this.selectedStatisticsDate = StatisticsDate.today,
      this.getStatisticsStatus = Status.initial,
      this.getStatisticsErrorMessage,
      this.statistics,
      this.selectedPeriodIndex});

  @override
  List<Object?> get props => [
        selectedDeviceId,
        selectedSensorType,
        selectedStatisticsDate,
        getStatisticsStatus,
        getStatisticsErrorMessage,
        statistics,
        selectedPeriodIndex,
      ];

  StatisticsState copyWith({
    String? selectedDeviceId,
    SensorType? selectedSensorType,
    StatisticsDate? selectedStatisticsDate,
    Status? getStatisticsStatus,
    String? getStatisticsErrorMessage,
    List<StatisticEntity>? statistics,
    int? selectedPeriodIndex,
  }) {
    return StatisticsState(
      selectedDeviceId: selectedDeviceId ?? this.selectedDeviceId,
      selectedSensorType: selectedSensorType ?? this.selectedSensorType,
      selectedStatisticsDate:
          selectedStatisticsDate ?? this.selectedStatisticsDate,
      getStatisticsStatus: getStatisticsStatus ?? this.getStatisticsStatus,
      getStatisticsErrorMessage:
          getStatisticsErrorMessage ?? this.getStatisticsErrorMessage,
      statistics: statistics ?? this.statistics,
      selectedPeriodIndex: selectedPeriodIndex ?? this.selectedPeriodIndex,
    );
  }
}

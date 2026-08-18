import 'package:naqaa/app/constants.dart';
import 'package:naqaa/data/models/statistic_model.dart';
import 'package:naqaa/domain/entities/statistic.dart';

extension StatisticModelExtension on StatisticModel? {
  StatisticEntity toDomain() => this == null
      ? StatisticEntity.empty()
      : StatisticEntity(
          tempHighest: this?.tempHighest ?? Constants.zero,
          tempLowest: this?.tempLowest ?? Constants.zero,
          tempAverage: this?.tempAverage ?? Constants.dZero,
          tdsHighest: this?.tdsHighest ?? Constants.zero,
          tdsLowest: this?.tdsLowest ?? Constants.zero,
          tdsAverage: this?.tdsAverage ?? Constants.dZero,
          phHighest: this?.phHighest ?? Constants.dZero,
          phLowest: this?.phLowest ?? Constants.dZero,
          phAverage: this?.phAverage ?? Constants.dZero,
          waterQuality: this?.waterQuality ?? Constants.zero,
        );
}

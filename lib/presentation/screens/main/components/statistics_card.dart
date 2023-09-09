import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:naqaa/app/enums/sensor_type_enum.dart';
import 'package:naqaa/app/enums/statistics_cart_type_ui_enum.dart';
import 'package:naqaa/app/extensions.dart';
import 'package:naqaa/domain/entities/statistic.dart';
import 'package:naqaa/presentation/blocs/statistics/statistics_cubit.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';

class StatisticsCard extends StatelessWidget {
  final SensorType type;
  final StatisticsCardTypeUi statisticsCardTypeUi;
  final List<StatisticEntity?> statistics;
  const StatisticsCard({
    Key? key,
    required this.type,
    required this.statisticsCardTypeUi,
    required this.statistics,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        final StatisticEntity? selectedPeriod = statistics.isNotEmpty
            ? statistics[state.selectedPeriodIndex ?? 0]
            : null;
        return Container(
          height: AppSizes.s130.r,
          width: AppSizes.s96.r,
          padding: const EdgeInsets.all(AppValues.mediumSmall).r,
          decoration: BoxDecoration(
            color: AppColors.snowWhite,
            borderRadius: BorderRadius.circular(AppValues.small),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppValues.smallRadius),
                    color: statisticsCardTypeUi.color.withOpacity(0.2)),
                child: SvgPicture.asset(
                  type.svgIcon,
                  height: AppSizes.s30.r,
                  width: AppSizes.s30.r,
                  colorFilter: ColorFilter.mode(
                      statisticsCardTypeUi.color, BlendMode.srcIn),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: '${statisticsCardTypeUi.name.tr()} ',
                      style: semiGrayExtraSmallStyle(),
                      children: [
                        TextSpan(
                          text: '(${type.unit()})',
                          style: semiGrayTinyStyle(),
                        ),
                      ],
                    ),
                  ),
                  if (selectedPeriod != null)
                    Text(
                      getSensorValue(
                          type, statisticsCardTypeUi, selectedPeriod),
                      style: semiBlackMediumStyle(),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String getSensorValue(SensorType sensorType,
      StatisticsCardTypeUi statisticsCardTypeUi, StatisticEntity statistic) {
    switch (sensorType) {
      case SensorType.temp:
        if (statisticsCardTypeUi.isHighest) {
          return statistic.tempHighest.toString();
        } else if (statisticsCardTypeUi.isLowest) {
          return statistic.tempLowest.toString();
        } else {
          return statistic.tempAverage.asString();
        }
      case SensorType.tds:
        if (statisticsCardTypeUi.isHighest) {
          return statistic.tdsHighest.toString();
        } else if (statisticsCardTypeUi.isLowest) {
          return statistic.tdsLowest.toString();
        } else {
          return statistic.tdsAverage.asString();
        }
      case SensorType.ph:
        if (statisticsCardTypeUi.isHighest) {
          return statistic.phHighest.toString();
        } else if (statisticsCardTypeUi.isLowest) {
          return statistic.phLowest.toString();
        } else {
          return statistic.phAverage.asString();
        }
    }
  }
}

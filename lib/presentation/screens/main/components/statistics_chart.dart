import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/app/enums/statistics_date_enum.dart';
import 'package:naqaa/app/extensions.dart';
import 'package:naqaa/presentation/blocs/statistics/statistics_cubit.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:ui' as ui;

import 'package:naqaa/app/enums/statistics_cart_type_ui_enum.dart';
import 'package:naqaa/domain/entities/statistic.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';

class StatisticsChart extends StatelessWidget {
  const StatisticsChart({
    Key? key,
    required this.statistics,
    required this.selectedPeriodIndex,
    required this.statisticsDate,
  }) : super(key: key);
  final List<StatisticEntity> statistics;
  final int selectedPeriodIndex;
  final StatisticsDate statisticsDate;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryYAxis: CategoryAxis(
        opposedPosition:
            Directionality.of(context) == ui.TextDirection.rtl ? true : false,
        labelAlignment: LabelAlignment.center,
        labelPlacement: LabelPlacement.onTicks,
        placeLabelsNearAxisLine: false,
        // desiredIntervals: 1,
        interval: 1,
        maximum: 7,
        minimum: 0,
        majorGridLines: const MajorGridLines(color: AppColors.pastelBlue),
        axisLabelFormatter: (AxisLabelRenderDetails args) {
          final text = int.parse(args.text).toWaterQualityName;
          return ChartAxisLabel(text, regularGrayTinyStyle());
        },
      ),
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(color: AppColors.transparent),
          majorTickLines: const MajorTickLines(color: AppColors.transparent),
          isInversed:
              Directionality.of(context) == ui.TextDirection.rtl ? true : false,
          axisLabelFormatter: (AxisLabelRenderDetails args) {
            final text = int.parse(args.text)
                .toStatisticsCardTypeUiTitle(statisticsDate);
            return ChartAxisLabel(text, regularGrayTinyStyle());
          }),
      series: <ChartSeries<ChartData, int>>[
        // Renders column chart
        ColumnSeries<ChartData, int>(
          dataSource: datasource(statistics),
          onPointTap: (pointInteractionDetails) =>
              BlocProvider.of<StatisticsCubit>(context).selectedPeriodIndex(
                  pointInteractionDetails.pointIndex ?? statistics.length - 1),
          color: AppColors.primary,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppValues.extraSmall.r)),
          xValueMapper: (ChartData data, _) => data.index,
          yValueMapper: (ChartData data, _) => data.waterQuality,
          pointColorMapper: (datum, index) => index == selectedPeriodIndex
              ? AppColors.primary
              : AppColors.pastelBlue,
        )
      ],
    );
  }

  List<ChartData> datasource(statistics) {
    List<ChartData> list = [];
    int index = 0;
    for (StatisticEntity statistic in statistics) {
      list.add(ChartData(
          periodOfTimeIndex: selectedPeriodIndex,
          waterQuality: statistic.waterQuality,
          index: index));
      index++;
    }
    return list;
  }
}

class ChartData {
  final int periodOfTimeIndex;
  final int index;
  final int waterQuality;

  ChartData({
    required this.periodOfTimeIndex,
    required this.index,
    required this.waterQuality,
  });
}

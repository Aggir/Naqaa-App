import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/enums/sensor_type_enum.dart';
import 'package:naqaa/app/enums/statistics_cart_type_ui_enum.dart';
import 'package:naqaa/app/enums/statistics_date_enum.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/presentation/blocs/devices/devices_cubit.dart';
import 'package:naqaa/presentation/blocs/statistics/statistics_cubit.dart';
import 'package:naqaa/presentation/screens/main/components/statistics_card.dart';
import 'package:naqaa/presentation/screens/main/components/statistics_chart.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_drop_down_field.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/dialog_service.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    final cubit = BlocProvider.of<StatisticsCubit>(context);
    cubit.init(
        BlocProvider.of<DevicesCubit>(context).state.latestDevicesSnapshot ??
            []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(title: AppStrings.statistics.tr()),
      body: PageContainer(
        child: BlocBuilder<DevicesCubit, DevicesState>(
          builder: (context, state) {
            if (state.latestDevicesSnapshot == null) {
              return _loadingState();
            } else if (state.latestDevicesSnapshot!.isEmpty) {
              return _emptyState(context);
            } else {
              return BlocListener<StatisticsCubit, StatisticsState>(
                listenWhen: (previous, current) =>
                    previous.getStatisticsStatus != current.getStatisticsStatus,
                listener: (context, state) {
                  if (state.getStatisticsStatus.isFailure) {
                    DialogService.dispose();
                    CustomToast.error(
                        context, state.getStatisticsErrorMessage!);
                  } else if (state.getStatisticsStatus.isSuccess) {
                    DialogService.dispose();
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _header(),
                    CustomSpacers.small(),
                    Text(
                      AppStrings.statisticsPageSubtitle.tr(),
                      style: regularGraySmallStyle(),
                    ),
                    CustomSpacers.large(),
                    _devicesDropDown(context),
                    CustomSpacers.medium(),
                    Container(
                      height: AppSizes.s240.r,
                      decoration: BoxDecoration(
                          color: AppColors.snowWhite,
                          borderRadius: BorderRadius.circular(AppValues.small)),
                      padding: const EdgeInsets.all(AppValues.mediumSmall).r,
                      child: BlocBuilder<StatisticsCubit, StatisticsState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    _selectableTab(
                                        context, StatisticsDate.today),
                                    CustomSpacers.small(),
                                    _selectableTab(
                                        context, StatisticsDate.sevenDays),
                                    CustomSpacers.small(),
                                    _selectableTab(
                                        context, StatisticsDate.month),
                                    CustomSpacers.small(),
                                    _selectableTab(
                                        context, StatisticsDate.sixMonths),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: StatisticsChart(
                                  statisticsDate: state.selectedStatisticsDate,
                                  selectedPeriodIndex:
                                      state.selectedPeriodIndex ?? 0,
                                  statistics: state.statistics ?? [],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    CustomSpacers.medium(),
                    _sensorSelectorRow(context),
                    CustomSpacers.medium(),
                    BlocBuilder<StatisticsCubit, StatisticsState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StatisticsCard(
                              type: state.selectedSensorType,
                              statisticsCardTypeUi:
                                  StatisticsCardTypeUi.highest,
                              statistics: state.statistics ?? [],
                            ),
                            StatisticsCard(
                              type: state.selectedSensorType,
                              statisticsCardTypeUi: StatisticsCardTypeUi.lowest,
                              statistics: state.statistics ?? [],
                            ),
                            StatisticsCard(
                              type: state.selectedSensorType,
                              statisticsCardTypeUi:
                                  StatisticsCardTypeUi.average,
                              statistics: state.statistics ?? [],
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _header() {
    return Text(
      AppStrings.statisticsPageTitle.tr(),
      style: mediumBlackLargeMediumStyle(),
    );
  }

  Widget _loadingState() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          CustomSpacers.extraLarge(),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            CustomSpacers.small(),
            Text(
              AppStrings.youDoNotHaveAnyDevicesYet.tr(),
              style: regularGraySmallStyle(),
            ),
            const Spacer(),
            Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(SvgAssets.emptyStatistics),
                CustomSpacers.medium(),
                Text(
                  AppStrings.thisPlaceIsEmptyTryAdding.tr(),
                  style: regularBluishGrayMediumStyle(),
                  textAlign: TextAlign.center,
                )
              ]),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _devicesDropDown(BuildContext context) {
    return BlocBuilder<DevicesCubit, DevicesState>(
      builder: (context, devicesState) {
        return BlocBuilder<StatisticsCubit, StatisticsState>(
          builder: (context, state) {
            return CustomDropDownField(
              color: AppColors.primary,
              secondaryColor: AppColors.cloudWhite,
              value: state.selectedDeviceId,
              onChanged: (value) {
                if (value != state.selectedDeviceId) {
                  BlocProvider.of<StatisticsCubit>(context).selectDevice(value);
                  DialogService.loadLoading(context);
                }
              },
              selectedItemBuilder: (context) =>
                  devicesState.latestDevicesSnapshot
                      ?.map(
                        (device) => DropdownMenuItem(
                          value: device.id,
                          child: Text(
                            device.name,
                            style: semiWhiteMediumStyle(),
                          ),
                        ),
                      )
                      .toList() ??
                  [],
              items: devicesState.latestDevicesSnapshot
                      ?.map(
                        (device) => DropdownMenuItem(
                          value: device.id,
                          child: Text(
                            device.name,
                            style: regularBlackStyle(),
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            );
          },
        );
      },
    );
  }

  Widget _selectableTab(BuildContext context, StatisticsDate statisticsDate) {
    return BlocBuilder<StatisticsCubit, StatisticsState>(
      builder: (context, state) {
        final bool isSelected = state.selectedStatisticsDate == statisticsDate;
        final borderRadius = BorderRadius.circular(AppValues.large.r);
        return Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                      vertical: AppValues.extraSmall,
                      horizontal: AppValues.mediumSmall)
                  .r,
              decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: isSelected ? AppColors.primary : AppColors.pastelBlue),
              child: Text(
                statisticsDate.name(),
                style: regularGrayTinyStyle().copyWith(
                    color: isSelected
                        ? AppColors.cloudWhite
                        : AppColors.bluishGray),
              ),
            ),
            Positioned.fill(
                child: Material(
              borderRadius: borderRadius,
              clipBehavior: Clip.antiAlias,
              color: AppColors.transparent,
              child: InkWell(
                onTap: () {
                  if (!isSelected) {
                    DialogService.loadLoading(context);
                    BlocProvider.of<StatisticsCubit>(context)
                        .selectStatisticsDate(statisticsDate);
                  }
                },
              ),
            ))
          ],
        );
      },
    );
  }

  Widget _sensorSelectorRow(BuildContext context) {
    return Row(
      children: [
        Text(
          AppStrings.waterQualityHighlights.tr(),
          style: mediumBlackMediumStyle(),
        ),
        CustomSpacers.small(),
        Flexible(
          child: BlocBuilder<StatisticsCubit, StatisticsState>(
            builder: (context, state) {
              return CustomDropDownField(
                  secondaryColor: AppColors.cloudWhite,
                  value: state.selectedSensorType.name(),
                  onChanged: (value) =>
                      BlocProvider.of<StatisticsCubit>(context)
                          .selectSensorType(value),
                  color: AppColors.primary,
                  selectedItemBuilder: (context) => SensorType.ph.list
                      .map(
                        (sensorType) => DropdownMenuItem(
                          value: sensorType.name(),
                          child: Text(
                            sensorType.name(),
                            style: regularWhiteSmallStyle(),
                          ),
                        ),
                      )
                      .toList(),
                  items: SensorType.ph.list
                      .map(
                        (sensorType) => DropdownMenuItem(
                          value: sensorType.name(),
                          child: Text(
                            sensorType.name(),
                            style: regularBlackStyle(),
                          ),
                        ),
                      )
                      .toList());
            },
          ),
        )
      ],
    );
  }
}

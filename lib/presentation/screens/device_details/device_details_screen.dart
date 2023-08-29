import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/enums/sensor_type_enum.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/domain/entities/device_details.dart';
import 'package:naqaa/presentation/blocs/devices/devices_cubit.dart';
import 'package:naqaa/presentation/screens/device_details/components/selectable_sensor_widget.dart';
import 'package:naqaa/presentation/screens/device_details/components/sensor_indicator_widget.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

class DeviceDetailsScreen extends StatefulWidget {
  const DeviceDetailsScreen({super.key});

  @override
  State<DeviceDetailsScreen> createState() => _DeviceDetailsScreenState();
}

class _DeviceDetailsScreenState extends State<DeviceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
        title: AppStrings.details.tr(),
        backButton: () => context.pop(),
      ),
      body: PageContainer(
        child: BlocBuilder<DevicesCubit, DevicesState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.selectedDevice?.name ?? Constants.empty,
                  style: mediumBlackExtraLargeStyle(),
                ),
                if (state.deviceDetailsStatus.isSuccess &&
                    state.deviceDetailsStream != null)
                  StreamBuilder<DeviceDetailsEntity>(
                    stream: state.deviceDetailsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Column(
                          children: [
                            CustomSpacers.extraLarge(),
                            const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        );
                      } else if (snapshot.hasData && snapshot.data != null) {
                        if (state.selectedSensor == null) {
                          BlocProvider.of<DevicesCubit>(context)
                              .selectSensor(SensorType.temp, snapshot.data!);
                        }
                        return _pageContent(
                            snapshot.data!, state.selectedDevice!);
                      }
                      return const SizedBox();
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _pageContent(DeviceDetailsEntity deviceDetails, DeviceEntity device) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${AppStrings.deviceStatus.tr()}: ',
              style: regularGrayStyle(),
            ),
            Text(
              (deviceDetails.isConnected
                      ? AppStrings.connected
                      : AppStrings.disconnected)
                  .tr(),
              style: semiBlackStyle().copyWith(
                color: deviceDetails.isConnected
                    ? AppColors.primary
                    : AppColors.red,
              ),
            ),
          ],
        ),
        CustomSpacers.large(),
        Center(
          child: SizedBox(
              width: AppSizes.s300.r,
              height: AppSizes.s300.r,
              child: const SensorIndicatorWidget()),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppStrings.waterQuality.tr()}: ",
              style: regularGrayStyle(),
            ),
            Text(
              device.waterQuality.tr(),
              style: regularBlackStyle()
                  .copyWith(color: colorFromHexString(device.hexColor)),
            )
          ],
        ),
        CustomSpacers.medium(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableSensorWidget(
              deviceDetails: deviceDetails,
              svgPath: SvgAssets.temp,
              name: AppStrings.temp.tr(),
              unit: AppStrings.tempUnit.tr(),
              value: deviceDetails.tempValue,
              type: SensorType.temp,
            ),
            SelectableSensorWidget(
              deviceDetails: deviceDetails,
              svgPath: SvgAssets.tds,
              name: AppStrings.tds.tr(),
              unit: AppStrings.tdsUnit.tr(),
              value: deviceDetails.tdsValue,
              type: SensorType.tds,
            ),
            SelectableSensorWidget(
              deviceDetails: deviceDetails,
              svgPath: SvgAssets.ph,
              name: AppStrings.ph.tr(),
              unit: AppStrings.phUnit.tr(),
              value: deviceDetails.phValue,
              type: SensorType.ph,
            ),
          ],
        )
      ],
    );
  }
}

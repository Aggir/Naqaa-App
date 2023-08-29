import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/enums/sensor_type_enum.dart';
import 'package:naqaa/app/extensions.dart';
import 'package:naqaa/presentation/blocs/devices/devices_cubit.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SensorIndicatorWidget extends StatelessWidget {
  const SensorIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DevicesCubit, DevicesState>(
      builder: (context, state) {
        return SfRadialGauge(
          axes: [
            RadialAxis(
              minimum: state.selectedSensor?.min ?? 0,
              maximum: state.selectedSensor?.max ?? 10,
              showLabels: false,
              tickOffset: 15.r,
              pointers: [
                RangePointer(
                  color: AppColors.primary,
                  cornerStyle: CornerStyle.bothCurve,
                  value: state.selectedSensor?.value ?? 0,
                  width: 20.r,
                )
              ],
              majorTickStyle:
                  MajorTickStyle(color: AppColors.primary.withOpacity(0.6)),
              minorTickStyle:
                  MinorTickStyle(color: AppColors.primary.withOpacity(0.6)),
              annotations: [
                GaugeAnnotation(
                  angle: 270,
                  horizontalAlignment: GaugeAlignment.center,
                  verticalAlignment: GaugeAlignment.center,
                  positionFactor: 0.07,
                  widget: Container(
                    height: AppSizes.s180.r,
                    width: AppSizes.s180.r,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(AppValues.circleRadius.r),
                    ),
                    alignment: Alignment.center,
                    child: Container(
                      height: AppSizes.s140.r,
                      width: AppSizes.s140.r,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius:
                            BorderRadius.circular(AppValues.circleRadius.r),
                      ),
                      padding: const EdgeInsets.all(AppValues.medium).r,
                      child: Column(children: [
                        Text(
                          state.selectedSensor?.max.asString() ??
                              Constants.empty,
                          style: regularPastelBlueSmallStyle(),
                        ),
                        Text(
                          state.selectedSensor?.value.asString() ??
                              Constants.empty,
                          style: semiWhiteHugeStyle(),
                        ),
                        Text(
                          state.selectedSensor?.type.unit() ?? Constants.empty,
                          style: regularWhiteMediumStyle(),
                        ),
                      ]),
                    ),
                  ),
                )
              ],
              axisLineStyle: AxisLineStyle(
                thickness: 20.r,
                cornerStyle: CornerStyle.bothCurve,
                color: AppColors.snowWhite,
              ),
            )
          ],
        );
      },
    );
  }
}

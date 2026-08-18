import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/enums/sensor_type_enum.dart';
import 'package:naqaa/app/extensions.dart';
import 'package:naqaa/domain/entities/device_details.dart';
import 'package:naqaa/presentation/blocs/devices/devices_cubit.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'dart:ui' as ui;

class SelectableSensorWidget extends StatelessWidget {
  const SelectableSensorWidget(
      {super.key,
      required this.deviceDetails,
      required this.svgPath,
      required this.name,
      required this.unit,
      required this.value,
      required this.type});
  final DeviceDetailsEntity deviceDetails;
  final String svgPath;
  final String name;
  final String unit;
  final double value;
  final SensorType type;

  void _selectSensor(BuildContext context) {
    BlocProvider.of<DevicesCubit>(context).selectSensor(type, deviceDetails);
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius =
        BorderRadius.circular(AppValues.smallRadius);
    return BlocBuilder<DevicesCubit, DevicesState>(
      builder: (context, state) {
        bool isSelected = type == state.selectedSensor?.type;
        return Stack(
          children: [
            Container(
              height: AppSizes.s130.r,
              width: AppSizes.s96.r,
              padding: const EdgeInsets.all(AppValues.mediumSmall).r,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.snowWhite,
                borderRadius: BorderRadius.circular(AppValues.small),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: borderRadius,
                        color: isSelected
                            ? AppColors.snowWhite
                            : AppColors.pastelBlue),
                    child: SvgPicture.asset(
                      svgPath,
                      height: AppSizes.s30.r,
                      width: AppSizes.s30.r,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (type != SensorType.ph)
                        Text.rich(
                          TextSpan(
                            text: '$name ',
                            style: semiGrayExtraSmallStyle().copyWith(
                              color: isSelected ? AppColors.cloudWhite : null,
                            ),
                            children: [
                              TextSpan(
                                text: '($unit)',
                                style: semiGrayTinyStyle().copyWith(
                                    color: isSelected
                                        ? AppColors.whiteText
                                        : null),
                              )
                            ],
                          ),
                        ),
                      if (type == SensorType.ph)
                        Directionality(
                          textDirection: ui.TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment: Directionality.of(context) ==
                                    ui.TextDirection.rtl
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              Text(
                                '$unit ',
                                style: semiGrayExtraSmallStyle().copyWith(
                                  color:
                                      isSelected ? AppColors.cloudWhite : null,
                                ),
                              ),
                              Text(
                                name,
                                style: semiGrayExtraSmallStyle().copyWith(
                                  color:
                                      isSelected ? AppColors.cloudWhite : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Text(
                        value.asString(),
                        style: semiBlackMediumStyle().copyWith(
                            color: isSelected ? AppColors.whiteText : null),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Positioned.fill(
                child: Material(
              color: AppColors.transparent,
              borderRadius: borderRadius,
              clipBehavior: Clip.antiAlias,
              child: InkWell(onTap: () => _selectSensor(context)),
            ))
          ],
        );
      },
    );
  }
}

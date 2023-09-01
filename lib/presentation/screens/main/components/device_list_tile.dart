import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/presentation/blocs/devices/devices_cubit.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_text_form_field.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

class DeviceListTile extends StatelessWidget {
  const DeviceListTile(this.device, {super.key});
  final DeviceEntity device;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DevicesCubit>(context);
    return BlocBuilder<DevicesCubit, DevicesState>(
      builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.snowWhite,
                  borderRadius: BorderRadius.circular(AppValues.small.r)),
              padding: const EdgeInsets.symmetric(
                      vertical: AppValues.medium,
                      horizontal: AppValues.mediumLarge)
                  .r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: AppSizes.s200.r,
                        child: (state.isEditing &&
                                state.selectedDevice?.id == device.id)
                            ? Form(
                                key: cubit.formKey,
                                child: CustomTextFormField(
                                  controller: cubit.nameController,
                                  customDecoration: const InputDecoration(
                                    errorStyle: TextStyle(height: 0),
                                  ),
                                ))
                            : Text(
                                device.name,
                                style: mediumBlackLargeStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                      ),
                      Material(
                        color: AppColors.transparent,
                        borderRadius:
                            BorderRadius.circular(AppValues.circleRadius),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: state.editDeviceNameStatus.isLoading
                              ? null
                              : () => state.isEditing
                                  ? cubit.saveEdit()
                                  : cubit.toggleEdit(device),
                          child: Padding(
                            padding:
                                const EdgeInsets.all(AppValues.mediumSmall).r,
                            child: state.editDeviceNameStatus.isLoading &&
                                    device == state.selectedDevice
                                ? SizedBox(
                                    width: AppSizes.s16.r,
                                    height: AppSizes.s16.r,
                                    child: const CircularProgressIndicator())
                                : SvgPicture.asset(
                                    (state.isEditing &&
                                            device == state.selectedDevice)
                                        ? SvgAssets.save
                                        : SvgAssets.pen,
                                    width: AppSizes.s16.r,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                  CustomSpacers.mediumLarge(),
                  BlocListener<DevicesCubit, DevicesState>(
                    listenWhen: (previous, current) =>
                        previous.deleteDeviceStatus !=
                        current.deleteDeviceStatus,
                    listener: (context, state) {
                      if (state.deleteDeviceStatus.isFailure) {
                        CustomToast.error(
                            context, state.deleteDeviceErrorMessage!);
                      } else if (state.deleteDeviceStatus.isSuccess) {
                        CustomToast.success(context,
                            AppStrings.removeDeviceSuccessMessage.tr());
                      }
                    },
                    child: BlocListener<DevicesCubit, DevicesState>(
                      listenWhen: (previous, current) =>
                          previous.editDeviceNameStatus !=
                          current.editDeviceNameStatus,
                      listener: (context, state) {
                        if (state.editDeviceNameStatus.isFailure) {
                          CustomToast.error(
                              context, state.editDeviceNameErrorMessage!);
                        } else if (state.editDeviceNameStatus.isSuccess) {
                          CustomToast.success(context,
                              AppStrings.editDeviceNameSuccessMessage.tr());
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.waterQuality.tr(),
                                style: regularGrayExtraSmallStyle(),
                              ),
                              CustomSpacers.small(),
                              Text(
                                device.waterQuality.tr(),
                                style: regularBlackStyle().copyWith(
                                    color: colorFromHexString(device.hexColor)),
                              )
                            ],
                          ),
                          BlocConsumer<DevicesCubit, DevicesState>(
                            listenWhen: (previous, current) =>
                                previous.deviceDetailsStatus !=
                                current.deviceDetailsStatus,
                            listener: (context, state) {
                              if (state.deviceDetailsStatus.isFailure) {
                                CustomToast.error(
                                    context, state.deviceDetailsErrorMessage!);
                              } else if (state.deviceDetailsStatus.isSuccess) {
                                context.push(AppScreen.deviceDetails.toPath);
                              }
                            },
                            builder: (context, state) {
                              if (state.isEditing &&
                                  state.selectedDevice?.id == device.id) {
                                return PrimaryButton(
                                  isLoading:
                                      state.deleteDeviceStatus.isLoading &&
                                          device.id == state.selectedDevice?.id,
                                  customSize: Size(100.r, 25.r),
                                  color: AppColors.red,
                                  onPressed: () => (state.deleteDeviceStatus
                                                  .isLoading ||
                                              state.editDeviceNameStatus
                                                  .isLoading) &&
                                          device.id == state.selectedDevice?.id
                                      ? null
                                      : cubit.deleteDevice(),
                                  child: Row(children: [
                                    SvgPicture.asset(
                                      SvgAssets.trash,
                                      height: AppSizes.s16.r,
                                      width: AppSizes.s16.r,
                                    ),
                                    CustomSpacers.small(),
                                    Text(AppStrings.remove.tr().toUpperCase())
                                  ]),
                                );
                              } else {
                                return PrimaryButton(
                                  isLoading:
                                      state.deviceDetailsStatus.isLoading &&
                                          device.id == state.selectedDevice?.id,
                                  customSize: Size(100.r, 25.r),
                                  onPressed: () => (state.deviceDetailsStatus
                                                  .isLoading ||
                                              state.editDeviceNameStatus
                                                  .isLoading) &&
                                          device.id == state.selectedDevice?.id
                                      ? null
                                      : cubit.deviceDetails(device),
                                  child: Text(
                                      AppStrings.details.tr().toUpperCase()),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (state.isEditing && state.selectedDevice != device)
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(AppValues.small)),
              ))
          ],
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/presentation/blocs/devices/devices_cubit.dart';
import 'package:naqaa/presentation/screens/main/components/setup_dialog.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_text_form_field.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

import '../../../blocs/user/user_cubit.dart';
import '../../../widgets/dialog_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _addDeviceFunction(BuildContext context) {
    context.push(AppScreen.setupDeviceOnboarding.toPath);
  }

  _detailsFunctions(BuildContext context) {}

  @override
  void initState() {
    super.initState();
    if (BlocProvider.of<UserCubit>(context).state.user?.isNewUser ?? false) {
      SchedulerBinding.instance.addPostFrameCallback(
        (_) => DialogService.load(
          context,
          isDismissible: false,
          content: const SetupDialog(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //todo: fetch the name from a cubit
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Text(
              "${AppStrings.hi.tr()}${state.user?.name ?? Constants.empty}",
              style: mediumBlackExtraLargeStyle(),
            );
          },
        ),

        BlocBuilder<DevicesCubit, DevicesState>(
          builder: (context, state) {
            if (state.fetchDevicesStatus.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.fetchDevicesStatus.isSuccess &&
                state.devicesStream != null) {
              return StreamBuilder<List<DeviceEntity>>(
                stream: state.devicesStream,
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
                  } else if (snapshot.hasData &&
                      (snapshot.data?.length ?? 0) > 0) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.yourDevicesAreWorkingHard.tr(),
                            style: regularGrayStyle(),
                          ),
                          CustomSpacers.mediumLarge(),
                          _devicesListView(snapshot),
                        ]);
                  }
                  return _homePageEmptyList(context);
                },
              );
            }
            return _homePageEmptyList(context);
          },
        )
      ]),
    );
  }

  Widget _devicesListView(AsyncSnapshot<List<DeviceEntity>> snapshot) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _deviceWidget(snapshot.data![index]);
        },
        separatorBuilder: (context, index) => CustomSpacers.medium(),
        itemCount: snapshot.data?.length ?? 0);
  }

  Widget _deviceWidget(DeviceEntity device) {
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
                                state.selectedDevice?.macAddress ==
                                    device.macAddress)
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
                  Row(
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
                      PrimaryButton(
                          onPressed: () => _detailsFunctions(context),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: AppValues.medium)
                                .r,
                            child: Text(AppStrings.details.tr()),
                          )),
                    ],
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

  Widget _homePageEmptyList(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _addDeviceFunction(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.youDoNotHaveAnyDevicesYet.tr(),
              style: regularGrayStyle(),
            ),
            const Spacer(),
            Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(SvgAssets.circlePlus),
                CustomSpacers.medium(),
                Text(
                  AppStrings.clickToAddADevice.tr(),
                  style: regularBluishGrayMediumStyle(),
                )
              ]),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

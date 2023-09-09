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
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/presentation/blocs/devices/devices_cubit.dart';
import 'package:naqaa/presentation/screens/main/components/device_list_tile.dart';
import 'package:naqaa/presentation/screens/main/components/setup_dialog.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

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
    return Scaffold(
      appBar: CustomAppBar.basic(title: AppStrings.home.tr(), actions: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: SizedBox(
            height: AppSizes.s48.r,
            width: AppSizes.s48.r,
            child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () {
                  GoRouter.of(context).push(AppScreen.faq.toPath);
                },
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    SvgAssets.info,
                    colorFilter:
                        ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                    height: AppSizes.s20.r,
                    width: AppSizes.s20.r,
                  ),
                )),
          ),
        )
      ]),
      body: PageContainer(
        child:
            BlocBuilder<DevicesCubit, DevicesState>(builder: (context, state) {
          if (state.fetchDevicesStatus.isLoading) {
            return _loadingState();
          } else if (state.fetchDevicesStatus.isSuccess &&
              state.latestDevicesSnapshot != null &&
              state.latestDevicesSnapshot!.isNotEmpty) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _welcomeWidget(),
                  Text(
                    AppStrings.yourDevicesAreWorkingHard.tr(),
                    style: regularGrayStyle(),
                  ),
                  CustomSpacers.mediumLarge(),
                  _devicesListView(state.latestDevicesSnapshot!),
                ]);
          } else {
            return _emptyState();
          }
        }),
      ),
    );
  }

  Widget _loadingState() {
    return Column(
      children: [
        _welcomeWidget(),
        CustomSpacers.extraLarge(),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  Widget _emptyState() {
    return IntrinsicHeight(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_welcomeWidget(), _homePageEmptyList(context)],
    ));
  }

  Widget _welcomeWidget() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Text(
          "${AppStrings.hi.tr()}${state.user?.name ?? Constants.empty}",
          style: mediumBlackExtraLargeStyle(),
        );
      },
    );
  }

  Widget _devicesListView(List<DeviceEntity> snapshot) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return DeviceListTile(snapshot[index]);
        },
        separatorBuilder: (context, index) => CustomSpacers.medium(),
        itemCount: snapshot.length);
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

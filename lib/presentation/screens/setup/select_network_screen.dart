import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/presentation/blocs/setup_device_select_network/setup_device_select_network_cubit.dart';
import 'package:naqaa/presentation/screens/setup/components/network_data_form_dailog.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/dialog_service.dart';
import 'package:wifi_scan/wifi_scan.dart';

import '../../widgets/page_container.dart';

class SetupDeviceSelectNetworkScreen extends StatefulWidget {
  const SetupDeviceSelectNetworkScreen({super.key});

  @override
  State<SetupDeviceSelectNetworkScreen> createState() =>
      _SetupDeviceSelectNetworkScreenState();
}

class _SetupDeviceSelectNetworkScreenState
    extends State<SetupDeviceSelectNetworkScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SetupDeviceSelectNetworkCubit>(context)
        .startListeningToScanResults();
  }

  void openNetworkFormFunction(
      BuildContext context, WiFiAccessPoint accessPoint) {
    final cubit = BlocProvider.of<SetupDeviceSelectNetworkCubit>(context);
    cubit.ssidController.text = accessPoint.ssid;
    cubit.selectNetwork(accessPoint.bssid);
    DialogService.load(
      context,
      isDismissible: false,
      backgroundColor: AppColors.cloudWhite,
      content: BlocProvider.value(
        value: cubit,
        child: const NetworkDataFormDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
        actions: [
          SizedBox(
            height: AppSizes.s48.r,
            width: AppSizes.s48.r,
            child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: () =>
                    BlocProvider.of<SetupDeviceSelectNetworkCubit>(context)
                        .refresh(),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    SvgAssets.refresh,
                    height: AppSizes.s16.r,
                    width: AppSizes.s16.r,
                  ),
                )),
          ),
        ],
        title: Constants.empty,
        backButton: () {
          context.pop(false);
        },
      ),
      body: BlocListener<SetupDeviceSelectNetworkCubit,
          SetupDeviceSelectNetworkState>(
        listenWhen: (previous, current) =>
            previous.connectStatus != current.connectStatus,
        listener: (context, state) {
          if (state.connectStatus.isFailure) {
            CustomToast.error(context, state.connectErrorMessage!);
          } else if (state.connectStatus.isSuccess) {
            DialogService.dispose();
            BlocProvider.of<SetupDeviceSelectNetworkCubit>(context)
                .passwordController
                .clear();
            // TODO: go to the next step.
          }
        },
        child: PageContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.chooseANetwork.tr(),
                style: boldBlackHugeStyle(),
              ),
              CustomSpacers.mediumLarge(),
              Text(
                AppStrings.chooseOneOfTheNetworks.tr(),
                style: regularGrayStyle(),
              ),
              Text(
                AppStrings.ifYourNetworkIsHidden.tr(),
                style: regularPrimaryStyle(),
              ),
              CustomSpacers.mediumLarge(),
              BlocBuilder<SetupDeviceSelectNetworkCubit,
                  SetupDeviceSelectNetworkState>(
                builder: (context, state) {
                  if (state.accessPoints?.isEmpty ?? true) {
                    return Container();
                  } else {
                    return Column(
                      children: [
                        ...state.accessPoints!
                            .map((e) => _wifiListTile(e))
                            .toList()
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _wifiListTile(WiFiAccessPoint accessPoint) {
    bool isWifiProtected() =>
        accessPoint.capabilities.toLowerCase().contains('wpa') ||
        accessPoint.capabilities.toLowerCase().contains('wep');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppValues.small).r,
      child: Material(
        color: AppColors.snowWhite,
        borderRadius: BorderRadius.circular(AppValues.smallRadius.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => openNetworkFormFunction(context, accessPoint),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: AppValues.mediumLarge,
              horizontal: AppValues.mediumLarge,
            ).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accessPoint.ssid,
                      style: semiBlackStyle(),
                    ),
                    Text(
                      (isWifiProtected()
                              ? AppStrings.protected
                              : AppStrings.open)
                          .tr(),
                      style: regularBluishGrayExtraSmallStyle(),
                    ),
                  ],
                ),
                SvgPicture.asset(
                  accessPoint.level >= -80
                      ? SvgAssets.wifiFull
                      : SvgAssets.wifiHalf,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

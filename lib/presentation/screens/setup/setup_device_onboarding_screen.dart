import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';

import '../../widgets/onboarding_page.dart';

class SetupDeviceOnboardingScreen extends StatefulWidget {
  const SetupDeviceOnboardingScreen({this.pageIndex, super.key});
  final int? pageIndex;

  @override
  State<SetupDeviceOnboardingScreen> createState() =>
      _SetupDeviceOnboardingScreenState();
}

class _SetupDeviceOnboardingScreenState
    extends State<SetupDeviceOnboardingScreen> {
  late Function navigateTo;
  late int currentIndex;

  @override
  void initState() {
    print(widget.pageIndex);
    currentIndex = widget.pageIndex ?? 0;
    super.initState();
  }

  Widget _indicator(Color color) {
    return Container(
      width: AppSizes.s8.r,
      height: AppSizes.s5.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s10.r),
        color: color,
      ),
    );
  }

  void _onIntroEnd(BuildContext context) {
    GoRouter.of(context).go(AppScreen.home.toPath);
  }

  void _onNext(BuildContext context) async {
    if (currentIndex == 1) {
      // bool setupSuccess =
      //     await context.push(AppScreen.setupDeviceSelectNetwork.toPath) as bool;
      // if (setupSuccess) {
      //   navigateTo(currentIndex + 1);
      // }
      context.go(AppScreen.setupDeviceSelectNetwork.toPath);
    } else {
      navigateTo(currentIndex + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
        title: Constants.empty,
        backButton: () {
          context.go(AppScreen.home.toPath);
        },
      ),
      body: IntroSlider(
        refFuncGoToTab: (function) {
          navigateTo = function;
          print(currentIndex);
          navigateTo(currentIndex);
        },
        onTabChangeCompleted: (index) {
          currentIndex = index;
        },
        backgroundColorAllTabs: AppColors.cloudWhite,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        listCustomTabs: [
          OnboardingPage(
            title: AppStrings.setupYourDevice,
            subtitleWidget: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: AppStrings.inOrderToConnectYourDevice.tr(),
                style: regularBluishGrayMediumStyle(),
                children: [
                  TextSpan(
                    text: AppStrings.locationPermission.tr(),
                    style: boldPrimaryMediumStyle(),
                  )
                ],
              ),
            ),
            svgPath: SvgAssets.setupOnboardingOne,
          ),
          OnboardingPage(
            title: AppStrings.setupYourDevice,
            subtitleWidget: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: AppStrings.nowChooseYour.tr(),
                style: regularBluishGrayMediumStyle(),
                children: [
                  TextSpan(
                    text: AppStrings.network.tr(),
                    style: boldPrimaryMediumStyle(),
                  ),
                  TextSpan(
                    text: AppStrings.andEnterThe.tr(),
                  ),
                  TextSpan(
                    text: AppStrings.password.tr(),
                    style: boldPrimaryMediumStyle(),
                  ),
                  TextSpan(
                    text: '${AppStrings.toConnectYourNaqaaDevice.tr()} 😁',
                  ),
                ],
              ),
            ),
            svgPath: SvgAssets.setupOnboardingTwo,
          ),
          const OnboardingPage(
            title: AppStrings.congratulations,
            subtitle: AppStrings.everythingIsSetupAndYouAreReadyToGo,
            svgPath: SvgAssets.setupOnboardingThree,
          ),
        ],
        isShowSkipBtn: false,
        isShowPrevBtn: true,
        onDonePress: () => _onIntroEnd(context),
        onNextPress: () => _onNext(context),
        renderDoneBtn: Text(AppStrings.done.tr().toUpperCase()),
        renderPrevBtn: Text(AppStrings.back.tr().toUpperCase()),
        customNextBtn: TextButton(
          child: Text(AppStrings.next.tr().toUpperCase()),
          onPressed: () => _onNext(context),
        ),
        indicatorConfig: IndicatorConfig(
          activeIndicatorWidget: _indicator(AppColors.primary),
          indicatorWidget: _indicator(AppColors.pastelBlue),
        ),
      ),
    );
  }
}

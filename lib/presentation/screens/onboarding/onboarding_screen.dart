import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:naqaa/app/helpers/app_service.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/language_manager.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

import 'components/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _onIntroEnd(context) {
    instance<AppService>().onboarding = true;
    GoRouter.of(context).go(AppScreen.signIn.toPath);
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

  @override
  Widget build(BuildContext context) {
    final String currentLanguage = getChangeLangText(context).toUpperCase();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cloudWhite,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () => switchLanguage(context),
              child: Text(currentLanguage),
            ),
          ],
        ),
        body: IntroSlider(
          backgroundColorAllTabs: AppColors.cloudWhite,
          listCustomTabs: const [
            OnboardingPage(
              title: AppStrings.onboardingOneTitle,
              subtitle: AppStrings.onboardingOneSubtitle,
              svgPath: SvgAssets.onBoardingOne,
            ),
            OnboardingPage(
              title: AppStrings.onboardingTwoTitle,
              subtitle: AppStrings.onboardingTwoSubtitle,
              svgPath: SvgAssets.onBoardingTwo,
            ),
            OnboardingPage(
              title: AppStrings.onboardingThreeTitle,
              subtitle: AppStrings.onboardingThreeSubtitle,
              svgPath: SvgAssets.onBoardingThree,
            ),
          ],
          onDonePress: () => _onIntroEnd(context),
          renderDoneBtn: Text(AppStrings.done.tr().toUpperCase()),
          renderSkipBtn: Text(AppStrings.skip.tr().toUpperCase()),
          renderNextBtn: Text(AppStrings.next.tr().toUpperCase()),
          indicatorConfig: IndicatorConfig(
            activeIndicatorWidget: _indicator(AppColors.primary),
            indicatorWidget: _indicator(AppColors.pastelBlue),
          ),
        ),
      ),
    );
  }
}

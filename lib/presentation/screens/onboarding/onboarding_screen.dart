import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/language_manager.dart';
import 'package:naqaa/presentation/app_router.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

import 'components/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  void _onIntroEnd(context) {
    GoRouter.of(context).go(Routes.loginRoute);
  }

  Widget _indicator(Color color) {
    return Container(
      width: AppSizes.s8,
      height: AppSizes.s5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.s10),
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
          backgroundColor: AppColors.white,
          elevation: 0,
          actions: [
            TextButton(
              onPressed: () => switchLanguage(context),
              child: Text(currentLanguage),
            ),
          ],
        ),
        body: IntroSlider(
          backgroundColorAllTabs: AppColors.white,
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
            indicatorWidget: _indicator(AppColors.almostWhiteBlue),
          ),
        ),
      ),
    );
  }
}

/*
Custom OnBoarding

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/presentation/screens/onboarding/components/get_started_button.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.large),
          child: Column(
            children: [
              SvgPicture.asset(
                SvgAssets.onBoardingOne,
                height: 334,
                width: 334,
              ),
              Text(
                AppStrings.onboardingOneTitle,
                style: onboardingTitleStyle(),
              ).tr(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppValues.medium),
                child: Text(
                  AppStrings.onboardingOneSubtitle,
                  style: onboardingSubtitleStyle(),
                  textAlign: TextAlign.center,
                ).tr(),
              ),
              GetStartedButton()
            ],
          ),
        ),
      ),
    );
  }
}

*/
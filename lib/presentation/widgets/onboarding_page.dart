import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/app_theme.dart';
import '../theme/text_style_manager.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    required this.svgPath,
    super.key,
  })  : assert((subtitle != null) || (subtitleWidget != null),
            'One of subtitle or subtitleWidget must be provided'),
        assert(
            ((subtitle != null) && (subtitleWidget == null)) ||
                ((subtitle == null) && (subtitleWidget != null)),
            'Only one [subtitle or subtitleWidget] must be provided');

  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppValues.mediumLarge - 5).r,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _onboardingDivider(),
            _onboardingDivider(),
            SvgPicture.asset(
              svgPath,
              height: AppSizes.s330.r,
              width: AppSizes.s330.r,
            ),
            _onboardingDivider(),
            Text(
              title,
              style: boldBlackExtraLargeStyle(),
            ).tr(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
              child: subtitleWidget ??
                  Text(
                    subtitle!,
                    style: regularBluishGrayMediumStyle(),
                    textAlign: TextAlign.center,
                  ).tr(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _onboardingDivider() {
    return SizedBox(height: AppSizes.s50.r, width: AppSizes.s50.r);
  }
}

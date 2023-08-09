import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.svgPath,
    super.key,
  });

  final String title;
  final String subtitle;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.large - 5).r,
      child: Column(
        children: [
          _onboardingDivider(),
          _onboardingDivider(),
          SvgPicture.asset(
            svgPath,
            height: 334,
            width: 334,
          ),
          _onboardingDivider(),
          Text(
            title,
            style: boldBlackExtraLargeStyle(),
          ).tr(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
            child: Text(
              subtitle,
              style: descriptionTextStyle(),
              textAlign: TextAlign.center,
            ).tr(),
          ),
        ],
      ),
    );
  }

  Widget _onboardingDivider() {
    return SizedBox(height: AppSizes.s50.r, width: AppSizes.s50.r);
  }
}

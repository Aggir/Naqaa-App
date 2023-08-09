import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_divider.dart';

import '../../../app/app_strings.dart';
import '../../widgets/custom_spacers.dart';
import '../../widgets/primary_button.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  void _acceptButtonFunction(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppValues.mediumLarge).r,
            child: Column(
              children: [
                _headerWidget(context),
                CustomSpacers.large(),
                _contentWidget(),
                const CustomDivider(),
                CustomSpacers.large(),
                PrimaryButton.fullWidth(
                  onPressed: () => _acceptButtonFunction(context),
                  child: Text(
                    AppStrings.accept.tr().toUpperCase(),
                  ),
                ),
                CustomSpacers.large(),
              ],
            )),
      ),
    );
  }

  Widget _headerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppValues.mediumLarge).r,
      child: Row(
        children: [
          SvgPicture.asset(
            SvgAssets.logoMark,
            height: AppSizes.s64.r,
            width: AppSizes.s64.r,
          ),
          CustomSpacers.medium(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.termsOfUse.tr(),
                style: boldDarkBlueLargeStyle(),
              ),
              CustomSpacers.small(),
              Text(
                AppStrings.lastUpdated.tr() + Constants.termsOfUseUpdateDate,
                style: regularGraySmallStyle(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // TODO: Refactor it
  Widget _contentWidget() {
    return Expanded(
        child: ListView(
      padding: const EdgeInsets.only(bottom: AppValues.small).r,
      shrinkWrap: true,
      children: [
        _sectionBody(AppStrings.termsOfUsePrefix.tr()),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionOne.tr()),
        _inSectionSpacer(),
        _sectionBody(AppStrings.termSectionOneDescription.tr()),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionTwo.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionTwoSubsectionOne.tr(),
          AppStrings.termSectionTwoSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionTwoSubsectionTwo.tr(),
          AppStrings.termSectionTwoSubsectionTwoDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionThree.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionThreeSubsectionOne.tr(),
          AppStrings.termSectionThreeSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionThreeSubsectionTwo.tr(),
          AppStrings.termSectionThreeSubsectionTwoDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionThreeSubsectionThree.tr(),
          AppStrings.termSectionThreeSubsectionThreeDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionFour.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionFourSubsectionOne.tr(),
          AppStrings.termSectionFourSubsectionOneDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionFive.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionFiveSubsectionOne.tr(),
          AppStrings.termSectionFiveSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionFiveSubsectionTwo.tr(),
          AppStrings.termSectionFiveSubsectionTwoDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionSix.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionSixSubsectionOne.tr(),
          AppStrings.termSectionSixSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionSixSubsectionTwo.tr(),
          AppStrings.termSectionSixSubsectionTwoDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionSeven.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionSevenSubsectionOne.tr(),
          AppStrings.termSectionSevenSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionSevenSubsectionTwo.tr(),
          AppStrings.termSectionSevenSubsectionTwoDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionEight.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionEightSubsectionOne.tr(),
          AppStrings.termSectionEightSubsectionOneDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionNine.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.termSectionNineSubsectionOne.tr(),
          AppStrings.termSectionNineSubsectionOneDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.termSectionEleven.tr()),
        _inSectionSpacer(),
        _sectionBody(
          AppStrings.termSectionElevenDescription.tr(),
        )
      ],
    ));
  }

  Widget _sectionSpacer() {
    return CustomSpacers.large();
  }

  Widget _inSectionSpacer() {
    return CustomSpacers.medium();
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: boldBlackMediumStyle(),
    );
  }

  Widget _subsection(String subsectionTitle, String subsectionBody) {
    return Text.rich(
      TextSpan(text: subsectionTitle, style: semiBlackSmallStyle(), children: [
        TextSpan(
          text: subsectionBody,
          style: regularBluishGraySmallStyle(),
        ),
      ]),
    );
  }

  Widget _sectionBody(String text) {
    return Text(
      text,
      style: regularBluishGraySmallStyle(),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  void _acceptButtonFunction(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppValues.mediumLarge),
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
      padding: const EdgeInsets.symmetric(vertical: AppValues.mediumLarge),
      child: Row(
        children: [
          SvgPicture.asset(
            SvgAssets.logoMark,
            height: AppSizes.s64,
            width: AppSizes.s64,
          ),
          CustomSpacers.medium(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.privacyAndPolicy.tr(),
                style: boldDarkBlueLargeStyle(),
              ),
              CustomSpacers.small(),
              Text(
                AppStrings.lastUpdated.tr() + Constants.privacyPolicyUpdateDate,
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
      padding: const EdgeInsets.only(bottom: AppValues.small),
      shrinkWrap: true,
      children: [
        _sectionBody(AppStrings.privacyPolicyPrefix.tr()),
        _sectionSpacer(),
        _sectionTitle(AppStrings.privacySectionOne.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionOneSubsectionOne.tr(),
          AppStrings.privacySectionOneSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionOneSubsectionTwo.tr(),
          AppStrings.privacySectionOneSubsectionTwoDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionOneSubsectionThree.tr(),
          AppStrings.privacySectionOneSubsectionThreeDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.privacySectionTwo.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionTwoSubsectionOne.tr(),
          AppStrings.privacySectionTwoSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionTwoSubsectionTwo.tr(),
          AppStrings.privacySectionTwoSubsectionTwoDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.privacySectionThree.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionThreeSubsectionOne.tr(),
          AppStrings.privacySectionThreeSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionThreeSubsectionTwo.tr(),
          AppStrings.privacySectionThreeSubsectionTwoDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.privacySectionFour.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionFourSubsectionOne.tr(),
          AppStrings.privacySectionFourSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionFourSubsectionTwo.tr(),
          AppStrings.privacySectionFourSubsectionTwoDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.privacySectionFive.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionFiveSubsectionOne.tr(),
          AppStrings.privacySectionFiveSubsectionOneDescription.tr(),
        ),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionFiveSubsectionTwo.tr(),
          AppStrings.privacySectionFiveSubsectionTwoDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.privacySectionSix.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionSixSubsectionOne.tr(),
          AppStrings.privacySectionSixSubsectionOneDescription.tr(),
        ),
        _sectionSpacer(),
        _sectionTitle(AppStrings.privacySectionSeven.tr()),
        _inSectionSpacer(),
        _subsection(
          AppStrings.privacySectionSevenSubsectionOne.tr(),
          AppStrings.privacySectionSevenSubsectionOneDescription.tr(),
        ),
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

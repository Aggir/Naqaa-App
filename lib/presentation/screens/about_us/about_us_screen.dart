import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_divider.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/app_strings.dart';
import '../../../app/assets_manager.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
        title: AppStrings.aboutUs.tr(),
        backButton: () => context.pop(),
      ),
      body: PageContainer(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.large).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              SvgAssets.fullLogo,
              height: AppSizes.s173.r,
            ),
            CustomSpacers.large(),
            Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                text: AppStrings.aboutUsDescription.tr(),
                style: regularBluishGrayMediumStyle(),
                children: [
                  TextSpan(
                    text: AppStrings.naqaaTeam.tr(),
                    style: regularPrimaryMediumStyle(),
                  ),
                  const TextSpan(text: '!'),
                ],
              ),
            ),
            CustomSpacers.large(),
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: const CustomDivider(),
            ),
            CustomSpacers.extraLarge(),
            developerSection(
              AppStrings.hussinSherif.tr(),
              Constants.hussinGithubUrl,
              Constants.hussinLinkedinUrl,
            ),
            CustomSpacers.mediumLarge(),
            developerSection(
              AppStrings.abdussalamAlmajdoub.tr(),
              Constants.abdussalamGithubUrl,
              Constants.abdussalamLinkedinUrl,
            ),
          ],
        ),
      ),
    );
  }

  Widget developerSection(
    String name,
    String githubURL,
    String linkedinURL,
  ) {
    return Column(
      children: [
        Text(
          name,
          style: semiBluishGrayStyle(),
        ),
        CustomSpacers.medium(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(AppValues.circleRadius),
              onTap: () async {
                if (await canLaunchUrl(Uri.parse(githubURL))) {
                  await launchUrl(Uri.parse(githubURL),
                      mode: LaunchMode.externalApplication);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(AppValues.extraSmall).r,
                child: SvgPicture.asset(
                  SvgAssets.gitHub,
                  height: AppSizes.s24.r,
                ),
              ),
            ),
            CustomSpacers.medium(),
            InkWell(
              borderRadius: BorderRadius.circular(AppValues.circleRadius),
              onTap: () async {
                if (await canLaunchUrl(Uri.parse(linkedinURL))) {
                  await launchUrl(Uri.parse(linkedinURL),
                      mode: LaunchMode.externalApplication);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(AppValues.extraSmall).r,
                child: SvgPicture.asset(
                  SvgAssets.linkedIn,
                  height: AppSizes.s24.r,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

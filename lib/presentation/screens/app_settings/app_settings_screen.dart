import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';

import '../../../app/language_manager.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../theme/text_style_manager.dart';
import '../../widgets/custom_divider.dart';
import '../../widgets/custom_spacers.dart';
import '../../widgets/page_container.dart';

class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({super.key});

  void _changeLanguageFunction(BuildContext context) {
    switchLanguage(context);
  }

  void _notificationsSettingsFunction(BuildContext context) {
    CustomToast.info(context, AppStrings.soon.tr());
  }

  void _termsOfUseFunction(BuildContext context) {
    context.push(AppScreen.termsOfUse.toPath);
  }

  void _privacyPolicyFunction(BuildContext context) {
    context.push(AppScreen.privacyPolicy.toPath);
  }

  void _aboutUsFunction(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
        title: AppStrings.appSettings.tr(),
        backButton: () => context.pop(),
      ),
      body: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSpacers.mediumLarge(),
            _sectionTitle(AppStrings.preferences.tr()),
            CustomSpacers.small(),
            _customListView(
              children: [
                _customListTile(
                  title: AppStrings.changeLanguage.tr(),
                  svgPath: SvgAssets.globe,
                  subtitle: getChangeLangText(context).tr(),
                  onTap: () => _changeLanguageFunction(context),
                ),
                _listDivider(),
                _customListTile(
                  title: AppStrings.notificationsSettings.tr(),
                  svgPath: SvgAssets.notification,
                  onTap: () => _notificationsSettingsFunction(context),
                ),
              ],
            ),
            CustomSpacers.large(),
            _sectionTitle(AppStrings.preferences.tr()),
            CustomSpacers.small(),
            _customListView(
              children: [
                _customListTile(
                  title: AppStrings.termsOfUse.tr(),
                  svgPath: SvgAssets.document,
                  onTap: () => _termsOfUseFunction(context),
                ),
                _listDivider(),
                _customListTile(
                  title: AppStrings.privacyAndPolicy.tr(),
                  svgPath: SvgAssets.shield,
                  onTap: () => _privacyPolicyFunction(context),
                ),
                _listDivider(),
                _customListTile(
                  title: AppStrings.aboutUs.tr(),
                  svgPath: SvgAssets.star,
                  onTap: () => _aboutUsFunction(context),
                ),
                _listDivider(),
                _customListTile(
                  title: AppStrings.appVersion.tr(),
                  svgPath: SvgAssets.info,
                  suffixText: Constants.appVersion,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppValues.medium),
      child: CustomDivider(),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: semiBlackMediumStyle(),
    );
  }

  Widget _customListTile({
    required String title,
    required String svgPath,
    String? subtitle,
    String? suffixText,
    void Function()? onTap,
    Color? themeColor,
  }) {
    return Material(
      color: AppColors.snowWhite,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppValues.medium),
          child: Row(
            children: [
              CircleAvatar(
                radius: AppSizes.s16,
                backgroundColor: themeColor?.withOpacity(0.10) ??
                    AppColors.primary.withOpacity(0.10),
                child: SvgPicture.asset(
                  svgPath,
                  height: AppSizes.s16,
                  colorFilter: ColorFilter.mode(
                    themeColor ?? AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              CustomSpacers.medium(),
              Row(
                children: [
                  Text(
                    title,
                    style: semiBlackStyle().copyWith(color: themeColor),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style:
                          semiBlackStyle().copyWith(color: AppColors.primary),
                    ),
                ],
              ),
              const Spacer(),
              if (suffixText != null)
                Text(
                  suffixText,
                  style: semiBluishGrayExtraSmallStyle(),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _customListView({required List<Widget> children}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: AppColors.snowWhite,
          borderRadius: BorderRadius.circular(AppValues.mediumSmallRadius)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppValues.mediumSmallRadius),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}

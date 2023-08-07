import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/blocs/auth/auth_cubit.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_divider.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _editProfileButtonFunction(BuildContext context) async {
    context.push(AppScreen.editProfile.toPath);
  }

  void _changePasswordButtonFunction(BuildContext context) async {
    context.push(AppScreen.changePassword.toPath);
  }

  void _appSettingsFunction(BuildContext context) async {
    context.push(AppScreen.appSettings.toPath);
  }

  void _checkForUpdatesFunction(BuildContext context) async {
    CustomToast.info(context, AppStrings.soon.tr());
  }

  void _signOutFunction(BuildContext context) async {
    await BlocProvider.of<AuthCubit>(context).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Column(
        children: [
          CustomSpacers.large(),
          _profilePicture(context),
          CustomSpacers.large(),
          _customListView(
            children: [
              _customListTile(
                onTap: () => _editProfileButtonFunction(context),
                title: AppStrings.editProfile.tr(),
                svgPath: SvgAssets.person,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppValues.medium),
                child: CustomDivider(),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (!(state.user?.isSignedInWithGoogle ?? false)) {
                    return _customListTile(
                      onTap: () => _changePasswordButtonFunction(context),
                      title: AppStrings.changePassword.tr(),
                      svgPath: SvgAssets.lock,
                    );
                  } else {
                    return _connectedWithGoogle();
                  }
                },
              ),
            ],
          ),
          CustomSpacers.mediumLarge(),
          _customListView(
            children: [
              _customListTile(
                onTap: () => _appSettingsFunction(context),
                title: AppStrings.appSettings.tr(),
                svgPath: SvgAssets.gear,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppValues.medium),
                child: CustomDivider(),
              ),
              _customListTile(
                onTap: () => _checkForUpdatesFunction(context),
                title: AppStrings.checkForUpdates.tr(),
                svgPath: SvgAssets.info,
              ),
            ],
          ),
          CustomSpacers.mediumLarge(),
          _customListView(
            children: [
              _customListTile(
                title: AppStrings.signOut.tr(),
                svgPath: SvgAssets.logout,
                themeColor: AppColors.lightRed,
                onTap: () => _signOutFunction(context),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _customListTile({
    required String title,
    required String svgPath,
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
              Text(
                title,
                style: semiBlackStyle().copyWith(color: themeColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profilePicture(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Column(
          children: [
            CircleAvatar(
              radius: AppSizes.s60,
              foregroundImage: state.user?.profilePictureUrl.isNotEmpty ?? false
                  ? NetworkImage(state.user!.profilePictureUrl)
                  : null,
              child: state.user?.profilePictureUrl.isEmpty ?? false
                  ? Text(
                      (state.user?.name[0] ?? Constants.empty).toUpperCase(),
                      style: boldWhiteHugeStyle(),
                    )
                  : null,
            ),
            CustomSpacers.medium(),
            Text(
              state.user?.name ?? Constants.empty,
              style: boldDarkBlueLargeStyle(),
            )
          ],
        );
      },
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

  Widget _connectedWithGoogle() {
    return Container(
      color: AppColors.snowWhite,
      padding: const EdgeInsets.all(AppValues.medium),
      child: Row(
        children: [
          CircleAvatar(
            radius: AppSizes.s16,
            backgroundColor: AppColors.primary.withOpacity(0.10),
            child: Opacity(
              opacity: 0.5,
              child: SvgPicture.asset(
                SvgAssets.google,
                height: AppSizes.s16,
              ),
            ),
          ),
          CustomSpacers.medium(),
          Opacity(
            opacity: 0.7,
            child: Text(
              AppStrings.connectedWithGoogle.tr(),
              style: semiGrayStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

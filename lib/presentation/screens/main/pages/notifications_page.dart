import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.basic(title: AppStrings.notifications.tr()),
        body: PageContainer(child: _emptyNotifications()));
  }

  Widget _emptyNotifications() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SvgAssets.notification,
            height: 100,
            colorFilter:
                const ColorFilter.mode(AppColors.pastelBlue, BlendMode.srcIn),
          ),
          CustomSpacers.medium(),
          Text(
            AppStrings.noActivityYet.tr(),
            style: regularDarkGrayMediumStyle(),
          ),
          CustomSpacers.small(),
          Text(
            AppStrings.yourNotificationsWillAppearHere.tr(),
            style: regularBluishGraySmallStyle(),
          ),
        ],
      ),
    );
  }
}

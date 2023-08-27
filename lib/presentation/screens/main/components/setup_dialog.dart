import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/dialog_service.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';
import 'package:naqaa/presentation/widgets/secondary_button.dart';

class SetupDialog extends StatefulWidget {
  const SetupDialog({super.key});

  @override
  State<SetupDialog> createState() => _SetupDialogState();
}

class _SetupDialogState extends State<SetupDialog> {
  void _setupNowFunction(BuildContext context) {
    DialogService.dispose();
    context.push(AppScreen.setupDeviceOnboarding.toPath);
  }

  void _setupLaterFunction(BuildContext context) {
    DialogService.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          SvgAssets.setupDialog,
          width: AppSizes.s200.r,
        ),
        CustomSpacers.mediumLarge(),
        FittedBox(
          child: Text(
            AppStrings.thatIsAnEmptyPlace.tr(),
            style: boldBlackLargeStyle(),
          ),
        ),
        CustomSpacers.extraSmall(),
        Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            text: AppStrings.itSeemsYouHaveNotSetUpAny.tr(),
            style: regularBluishGraySmallStyle(),
            children: [
              TextSpan(
                text: AppStrings.devices.tr(),
                style: regularPrimarySmallStyle(),
              ),
              TextSpan(
                text: AppStrings.yetLetUsDoThatNow.tr(),
              ),
            ],
          ),
        ),
        CustomSpacers.medium(),
        PrimaryButton.fullWidth(
          onPressed: () => _setupNowFunction(context),
          child: Text(
            AppStrings.setupNow.tr().toUpperCase(),
          ),
        ),
        CustomSpacers.medium(),
        SecondaryButton.fullWidth(
          onPressed: () => _setupLaterFunction(context),
          child: Text(
            AppStrings.setupLater.tr().toUpperCase(),
          ),
        )
      ],
    );
  }
}

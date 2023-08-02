import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/widgets/secondary_icon_button.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/app_colors.dart';

class ConnectWithGoogleButton extends StatelessWidget {
  const ConnectWithGoogleButton({
    required this.isLoading,
    required this.onPressed,
    super.key,
  });
  final void Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (isLoading)
          Positioned.fill(
            child: Shimmer.fromColors(
              baseColor: AppColors.mediumGray.withOpacity(0),
              highlightColor: AppColors.primary.withOpacity(0.2),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.snowWhite,
                    borderRadius:
                        BorderRadius.circular(AppValues.primaryButtonRadius)),
              ),
            ),
          ),
        SizedBox(
          width: double.infinity,
          child: SecondaryIconButton(
            onPressed: isLoading ? null : onPressed,
            icon: SvgPicture.asset(
              SvgAssets.google,
              height: AppSizes.s24,
              width: AppSizes.s24,
            ),
            label: Text(
              AppStrings.connectWithGoogle.tr().toUpperCase(),
            ),
          ),
        ),
      ],
    );
  }
}

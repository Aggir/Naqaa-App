import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:naqaa/presentation/widgets/custom_spacers.dart';

import '../../../../app/app_strings.dart';
import '../../../../app/assets_manager.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_theme.dart';
import '../../../theme/text_style_manager.dart';

class ImagePickerBottomSheet extends StatelessWidget {
  const ImagePickerBottomSheet({super.key});

  void _openCamera(BuildContext context) {
    context.pop(true);
  }

  void _openGallery(BuildContext context) {
    context.pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppValues.large).r,
      shrinkWrap: true,
      children: [
        _customListTile(
          AppStrings.takePicture.tr(),
          SvgAssets.camera,
          () => _openCamera(context),
        ),
        CustomSpacers.medium(),
        _customListTile(
          AppStrings.chooseFromGallery.tr(),
          SvgAssets.image,
          () => _openGallery(context),
        ),
      ],
    );
  }

  Widget _customListTile(String title, String svgPath, void Function()? onTap) {
    return Material(
      color: AppColors.snowWhite,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppValues.medium).r,
          child: Row(
            children: [
              CircleAvatar(
                radius: AppSizes.s16,
                backgroundColor: AppColors.primary.withOpacity(0.10),
                child: SvgPicture.asset(
                  svgPath,
                  height: AppSizes.s16,
                  colorFilter: ColorFilter.mode(
                    AppColors.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              CustomSpacers.medium(),
              Text(
                title,
                style: semiBlackStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

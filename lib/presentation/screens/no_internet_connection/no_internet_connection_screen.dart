import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(title: ''),
      body: PageContainer(
        child: IntrinsicHeight(
          child: Column(
            children: [
              SvgPicture.asset(
                SvgAssets.noConnection,
                height: AppSizes.s330.r,
                width: AppSizes.s330.r,
              ),
              Text(
                AppStrings.noInternet.tr(),
                style: boldBlackExtraLargeStyle(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppValues.medium).r,
                child: Text(
                  AppStrings.noInternetScreenSubtitle.tr(),
                  style: regularBluishGrayMediumStyle(),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

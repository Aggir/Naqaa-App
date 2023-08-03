import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _addDeviceFunction(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.home.tr(),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: constraints.copyWith(
              minHeight: constraints.maxHeight,
              maxHeight: double.infinity,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppValues.large),
              child: IntrinsicHeight(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //todo: fetch the name from a cubit
                      Text(
                        "${AppStrings.hi.tr()}${FirebaseAuth.instance.currentUser?.displayName}",
                        style: mediumBlackExtraLargeStyle(),
                      ),
                      _homePageEmptyList(context)
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _homePageEmptyList(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _addDeviceFunction(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.youDoNotHaveAnyDevicesYet.tr(),
              style: regularGrayStyle(),
            ),
            const Spacer(),
            Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SvgPicture.asset(SvgAssets.circlePlus),
                CustomSpacers.medium(),
                Text(
                  AppStrings.clickToAddADevice.tr(),
                  style: regularBluishGrayMediumStyle(),
                )
              ]),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

import '../../../blocs/auth/auth_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _addDeviceFunction(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //todo: fetch the name from a cubit
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Text(
              "${AppStrings.hi.tr()}${state.user?.name}",
              style: mediumBlackExtraLargeStyle(),
            );
          },
        ),
        _homePageEmptyList(context)
      ]),
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

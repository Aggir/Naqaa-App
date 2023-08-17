import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/screens/main/components/setup_dialog.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

import '../../../blocs/user/user_cubit.dart';
import '../../../widgets/dialog_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _addDeviceFunction(BuildContext context) {
    context.push(AppScreen.setupDeviceOnboarding.toPath);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) => DialogService.load(
        context,
        isDismissible: false,
        content: const SetupDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //todo: fetch the name from a cubit
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Text(
              "${AppStrings.hi.tr()}${state.user?.name ?? Constants.empty}",
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

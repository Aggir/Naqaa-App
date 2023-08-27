import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/presentation/blocs/setup_device/setup_device_cubit.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';

class SetupDeviceScreen extends StatefulWidget {
  const SetupDeviceScreen(this.child, {super.key});
  final StatefulNavigationShell child;

  @override
  State<SetupDeviceScreen> createState() => _SetupDeviceScreenState();
}

class _SetupDeviceScreenState extends State<SetupDeviceScreen> {
  AppBar? _appBar() {
    switch (widget.child.currentIndex) {
      case 0:
        return CustomAppBar.basic(
          actions: [
            SizedBox(
              height: AppSizes.s48.r,
              width: AppSizes.s48.r,
              child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () =>
                      BlocProvider.of<SetupDeviceCubit>(context).refresh(),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SvgPicture.asset(
                      SvgAssets.refresh,
                      height: AppSizes.s16.r,
                      width: AppSizes.s16.r,
                    ),
                  )),
            ),
          ],
          title: Constants.empty,
          backButton: () {
            context.pop(false);
          },
        );
      case 1:
        return CustomAppBar.basic(
          title: Constants.empty,
        );
      default:
        return CustomAppBar.basic(
            title: Constants.empty,
            backButton: () {
              widget.child.goBranch(widget.child.currentIndex - 1);
            });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: widget.child,
    );
  }
}

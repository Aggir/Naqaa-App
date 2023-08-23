import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/presentation/blocs/setup_device_select_network/setup_device_select_network_cubit.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';

class SetupDeviceScreen extends StatefulWidget {
  const SetupDeviceScreen(this.child, {super.key});
  final StatefulNavigationShell child;

  @override
  State<SetupDeviceScreen> createState() => _SetupDeviceScreenState();
}

class _SetupDeviceScreenState extends State<SetupDeviceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
        actions: widget.child.currentIndex == 0
            ? [
                SizedBox(
                  height: AppSizes.s48.r,
                  width: AppSizes.s48.r,
                  child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () =>
                          BlocProvider.of<SetupDeviceSelectNetworkCubit>(
                                  context)
                              .refresh(),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: SvgPicture.asset(
                          SvgAssets.refresh,
                          height: AppSizes.s16.r,
                          width: AppSizes.s16.r,
                        ),
                      )),
                ),
              ]
            : null,
        title: Constants.empty,
        backButton: () {
          if (widget.child.currentIndex == 0) {
            context.pop(false);
          } else {
            widget.child.goBranch(widget.child.currentIndex - 1);
          }
        },
      ),
      body: widget.child,
    );
  }
}

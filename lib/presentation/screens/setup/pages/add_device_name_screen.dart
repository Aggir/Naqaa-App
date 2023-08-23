import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/blocs/setup_device_select_network/setup_device_select_network_cubit.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';

class SetupDeviceAddDeviceNameScreen extends StatelessWidget {
  const SetupDeviceAddDeviceNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('name'),
    );
  }
}

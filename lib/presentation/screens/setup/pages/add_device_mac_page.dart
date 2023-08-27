import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
// import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/blocs/setup_device/setup_device_cubit.dart';
// import 'package:naqaa/presentation/theme/app_colors.dart';
// import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_text_form_field.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

class SetupDeviceAddDeviceMacPage extends StatelessWidget {
  const SetupDeviceAddDeviceMacPage({super.key});

  void _finishSetupFunction(BuildContext context) {
    final cubit = BlocProvider.of<SetupDeviceCubit>(context);
    if (cubit.deviceMacForm.currentState?.validate() ?? false) {
      //TODO: Add "ADD DEVICE API INTEGRATION"
      cubit.addDevice();
    }
  }

  //TODO: ADD qr code scanner
  //TODO: add MAC input validation
  // void _scanQrCode(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SetupDeviceCubit>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: PageContainer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.enterTheDeviceMacAddress.tr(),
            style: boldBlackHugeStyle(),
          ),
          CustomSpacers.mediumLarge(),
          Text(
            AppStrings.enterOrScanTheQrCodeMac.tr(),
            style: regularGrayStyle(),
          ),
          CustomSpacers.medium(),
          Form(
            key: cubit.deviceMacForm,
            child: CustomTextFormField(
              controller: cubit.deviceMacController,
              customDecoration: InputDecoration(
                hintText: AppStrings.macAddressHint.tr(),
                errorStyle: const TextStyle(height: 0),
                // suffixIcon: Material(
                //   color: AppColors.transparent,
                //   borderRadius:
                //       BorderRadius.circular(AppValues.mediumSmallRadius.r),
                //   clipBehavior: Clip.antiAlias,
                //   child: InkWell(
                //     onTap: () => _scanQrCode(context),
                //     child: FittedBox(
                //         fit: BoxFit.scaleDown,
                //         child: SvgPicture.asset(
                //           SvgAssets.qrCode,
                //           height: AppSizes.s26.r,
                //         )),
                //   ),
                // ),
              ),
            ),
          ),
          CustomSpacers.large(),
          BlocBuilder<SetupDeviceCubit, SetupDeviceState>(
            builder: (context, state) {
              return PrimaryButton.fullWidth(
                onPressed: () => _finishSetupFunction(context),
                child: Text(AppStrings.finishSetup.tr().toUpperCase()),
              );
            },
          ),
        ],
      )),
    );
  }
}

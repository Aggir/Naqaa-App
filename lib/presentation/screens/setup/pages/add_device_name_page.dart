import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/blocs/setup_device/setup_device_cubit.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_text_form_field.dart';
import 'package:naqaa/presentation/widgets/custom_toast.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';
import 'package:naqaa/presentation/widgets/primary_button.dart';

class SetupDeviceAddDeviceNamePage extends StatelessWidget {
  const SetupDeviceAddDeviceNamePage({super.key});

  void _continueButtonFunction(BuildContext context) {
    final cubit = BlocProvider.of<SetupDeviceCubit>(context);
    cubit.deviceNameFocusNode.unfocus();
    if (cubit.deviceNameForm.currentState?.validate() ?? false) {
      cubit.addDevice();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SetupDeviceCubit>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocListener<SetupDeviceCubit, SetupDeviceState>(
        listenWhen: (previous, current) =>
            previous.addDeviceStatus != current.addDeviceStatus,
        listener: (context, state) {
          if (state.addDeviceStatus.isSuccess) {
            context.go(AppScreen.setupDeviceOnboarding.toPath, extra: 2);
          } else if (state.addDeviceStatus.isFailure) {
            CustomToast.error(context, state.addDeviceErrorMessage!);
          }
        },
        child: PageContainer(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.chooseName.tr(),
              style: boldBlackHugeStyle(),
            ),
            CustomSpacers.mediumLarge(),
            Text.rich(
              TextSpan(
                  text: AppStrings.enterNameForYour.tr(),
                  style: regularGrayStyle(),
                  children: [
                    TextSpan(
                        text: AppStrings.device.tr(),
                        style: regularPrimaryStyle()),
                    TextSpan(text: AppStrings.soYouCanEasilyRemember.tr())
                  ]),
            ),
            CustomSpacers.medium(),
            Form(
              key: cubit.deviceNameForm,
              child: CustomTextFormField(
                controller: cubit.deviceNameController,
                focusNode: cubit.deviceNameFocusNode,
                customDecoration: InputDecoration(
                  errorStyle: const TextStyle(height: 0),
                  labelText: AppStrings.enterName.tr(),
                ),
              ),
            ),
            CustomSpacers.large(),
            PrimaryButton.fullWidth(
                onPressed: () => _continueButtonFunction(context),
                child: Text(AppStrings.continueButton.tr().toUpperCase()))
          ],
        )),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/app/validators.dart';
import 'package:naqaa/presentation/blocs/setup_device_select_network/setup_device_select_network_cubit.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/custom_text_button.dart';
import 'package:naqaa/presentation/widgets/custom_text_form_field.dart';
import 'package:naqaa/presentation/widgets/dialog_service.dart';

class NetworkDataFormDialog extends StatelessWidget {
  const NetworkDataFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SetupDeviceSelectNetworkCubit>(context);
    return Form(
      key: cubit.networkDataForm,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.connectToTheNetwork.tr(),
            style: boldBlackMediumStyle(),
          ),
          CustomSpacers.mediumLarge(),
          CustomTextFormField(
            hintText: AppStrings.network.tr(),
            controller: cubit.ssidController,
            readOnly: true,
            enabled: false,
          ),
          CustomSpacers.medium(),
          CustomTextFormField(
            hintText: AppStrings.password.tr(),
            controller: cubit.passwordController,
            focusNode: cubit.passwordFocusNode,
            isPassword: true,
            validator: passwordValidator,
          ),
          BlocBuilder<SetupDeviceSelectNetworkCubit,
              SetupDeviceSelectNetworkState>(builder: (context, state) {
            if (state.connectStatus.isFailure) {
              return Text(
                state.connectErrorMessage!,
                style: regularRedExtraSmallStyle(),
              );
            } else {
              return Container();
            }
          }),
          CustomSpacers.mediumLarge(),
          BlocBuilder<SetupDeviceSelectNetworkCubit,
              SetupDeviceSelectNetworkState>(
            builder: (context, state) {
              if (state.connectStatus.isLoading) {
                return const CircularProgressIndicator();
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      onPressed: () => DialogService.dispose(),
                      text: AppStrings.cancel.tr(),
                      textColor: AppColors.blackText,
                    ),
                    CustomSpacers.small(),
                    CustomTextButton(
                      onPressed: () => cubit.connect(),
                      text: AppStrings.connect.tr(),
                    ),
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/presentation/widgets/secondary_icon_button.dart';

class ConnectWithGoogleButton extends StatelessWidget {
  const ConnectWithGoogleButton({required this.onPressed, super.key});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SecondaryIconButton(
        onPressed: onPressed,
        icon: SvgPicture.asset(
          SvgAssets.google,
          height: 24,
          width: 24,
        ),
        label: Text(
          AppStrings.connectWithGoogle.tr().toUpperCase(),
        ),
      ),
    );
  }
}

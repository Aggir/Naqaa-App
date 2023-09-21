import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';

class DialogService {
  const DialogService._();

  static IDialog? _current;

  static Future<void> load(BuildContext context,
      {required Widget content,
      List<Widget>? actions,
      Color? backgroundColor,
      bool isDismissible = true}) async {
    _current = CustomDialog(
        content: content, actions: actions, backgroundColor: backgroundColor);

    await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      useSafeArea: false,
      builder: (context) =>
          _current ??
          CustomDialog(
            content: content,
            actions: actions,
          ),
    );
  }

  static Future<void> loadLoading(BuildContext context,
      {Color? backgroundColor, bool isDismissible = true}) async {
    final Widget content = SizedBox(
      height: AppSizes.s150.r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: AppSizes.s30.r,
            width: AppSizes.s30.r,
            child: const CircularProgressIndicator(),
          )
        ],
      ),
    );
    _current = CustomDialog(
      content: content,
      backgroundColor: backgroundColor,
      removeBackground: true,
    );

    await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      useSafeArea: false,
      builder: (context) =>
          _current ??
          CustomDialog(
            removeBackground: true,
            content: content,
          ),
    );
  }

  static void dispose() {
    if (_current != null) {
      _current!.dismiss();
      _current = null;
    }
  }
}

mixin IDialogService {
  void dismiss();
}

abstract class IDialog extends StatelessWidget with IDialogService {
  const IDialog({Key? key}) : super(key: key);
}

// ignore: must_be_immutable
class CustomDialog extends IDialog {
  CustomDialog(
      {required this.content,
      this.actions,
      this.backgroundColor,
      this.removeBackground = false,
      super.key});
  Widget content;
  List<Widget>? actions;
  BuildContext? _context;
  Color? backgroundColor;
  bool removeBackground;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return AlertDialog(
      contentPadding: EdgeInsets.all(AppValues.mediumLarge.r),
      content: content,
      actions: actions,
      backgroundColor:
          removeBackground ? AppColors.transparent : backgroundColor,
      elevation: removeBackground ? 0 : null,
      shape: removeBackground
          ? null
          : RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppValues.mediumRadius.r),
            ),
    );
  }

  @override
  void dismiss() {
    Navigator.pop(_context!);
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/presentation/app_router.dart';
import 'package:naqaa/presentation/widgets/custom_back_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen(this.child, {super.key});
  final StatefulNavigationShell child;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(onTap: () {
          if (widget.child.currentIndex > 0) {
            widget.child.goBranch(widget.child.currentIndex - 1);
          } else {
            context.go(Routes.signInRoute);
          }
        }),
      ),
      body: widget.child,
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({required this.child, this.padding, super.key});
  final Widget child;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: constraints.copyWith(
            minHeight: constraints.maxHeight,
            maxHeight: double.infinity,
          ),
          child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(
                    vertical: AppValues.large,
                    horizontal: AppValues.mediumLarge),
            child: IntrinsicHeight(child: child),
          ),
        ),
      ),
    );
  }
}

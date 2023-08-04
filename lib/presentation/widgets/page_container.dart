import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PageContainer extends StatelessWidget {
  const PageContainer({required this.child, super.key});
  final Widget child;
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
            padding: const EdgeInsets.all(AppValues.large),
            child: IntrinsicHeight(child: child),
          ),
        ),
      ),
    );
  }
}

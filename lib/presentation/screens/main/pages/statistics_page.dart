import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.basic(title: AppStrings.statistics.tr()),
        body: const Center(child: Text('Statistics')));
  }
}

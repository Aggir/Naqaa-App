import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/router/routes.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';

import '../../../app/app_strings.dart';
import '../../../app/assets_manager.dart';
import '../../theme/app_theme.dart';
import '../../theme/text_style_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(this.child, this.location, {super.key});
  final Widget child;
  final Uri location;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _plusButtonFunction(BuildContext context) {
    context.go(AppScreen.setupDeviceOnboarding.toPath);
  }

  final List<Map<String, String>> _navBarItems = [
    {
      'label': AppStrings.home.tr(),
      'filledSvgPath': SvgAssets.homeFilled,
      "svgPath": SvgAssets.home,
      "path": AppScreen.home.toPath,
    },
    {
      'label': AppStrings.statistics.tr(),
      'filledSvgPath': SvgAssets.statisticFilled,
      "svgPath": SvgAssets.statistic,
      "path": AppScreen.statistics.toPath,
    },
    {
      'label': AppStrings.notifications.tr(),
      'filledSvgPath': SvgAssets.notificationFilled,
      "svgPath": SvgAssets.notification,
      "path": AppScreen.notifications.toPath,
    },
    {
      'label': AppStrings.settings.tr(),
      'filledSvgPath': SvgAssets.personFilled,
      "svgPath": SvgAssets.person,
      "path": AppScreen.settings.toPath,
    },
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = _navBarItems
        .indexWhere((element) => element['path'] == widget.location.toString());
    // todo: Refactor it
    return Scaffold(
      appBar: CustomAppBar.basic(
          title: _navBarItems[currentIndex]['label'],
          backButton: widget.location.pathSegments.length > 1
              ? () => context.pop()
              : null),
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _plusButtonFunction(context),
        tooltip: 'Increment',
        backgroundColor: AppColors.primary,
        elevation: 1.0,
        child: SvgPicture.asset(
          SvgAssets.plus,
          height: AppSizes.s22.r,
          width: AppSizes.s22.r,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: AppSizes.s72.r,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                _navBar(
                    label: _navBarItems[0]['label']!,
                    filledSvgPath: _navBarItems[0]['filledSvgPath']!,
                    svgPath: _navBarItems[0]['svgPath']!,
                    index: 0,
                    currentIndex: currentIndex,
                    path: _navBarItems[0]['path']!),
                _navBar(
                    label: _navBarItems[1]['label']!,
                    filledSvgPath: _navBarItems[1]['filledSvgPath']!,
                    svgPath: _navBarItems[1]['svgPath']!,
                    index: 1,
                    currentIndex: currentIndex,
                    path: _navBarItems[1]['path']!),
                CustomSpacers.medium(),
                _navBar(
                    label: _navBarItems[2]['label']!,
                    filledSvgPath: _navBarItems[2]['filledSvgPath']!,
                    svgPath: _navBarItems[2]['svgPath']!,
                    index: 2,
                    currentIndex: currentIndex,
                    path: _navBarItems[2]['path']!),
                _navBar(
                    label: _navBarItems[3]['label']!,
                    filledSvgPath: _navBarItems[3]['filledSvgPath']!,
                    svgPath: _navBarItems[3]['svgPath']!,
                    index: 3,
                    currentIndex: currentIndex,
                    path: _navBarItems[3]['path']!),
              ]),
        ),
      ),
    );
  }

  Widget _navBar(
      {required String label,
      required String filledSvgPath,
      required String svgPath,
      required String path,
      required int index,
      required int currentIndex}) {
    bool isSelected = index == currentIndex;
    return InkWell(
      borderRadius: BorderRadius.circular(AppValues.circleRadius),
      onTap: () {
        context.go(path);
      },
      child: SizedBox(
        width: AppSizes.s70.r,
        height: AppSizes.s70.r,
        child: AnimatedContainer(
          alignment: Alignment.center,
          width: AppSizes.s70.r,
          height: isSelected ? AppSizes.s50.r : AppSizes.s30.r,
          duration: const Duration(milliseconds: 150),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  isSelected ? filledSvgPath : svgPath,
                  height: isSelected ? AppSizes.s22.r : AppSizes.s20.r,
                  width: isSelected ? AppSizes.s22.r : AppSizes.s20.r,
                  colorFilter: isSelected
                      ? null
                      : ColorFilter.mode(
                          AppColors.primary.withOpacity(0.8), BlendMode.srcIn),
                ),
                if (isSelected)
                  Text(
                    label,
                    style: boldPrimaryExtraSmallStyle(),
                    maxLines: 1,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/extensions.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_divider.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.basic(
          title: AppStrings.faq, backButton: () => context.pop()),
      body: PageContainer(
          child: Column(
        children: [
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.whatIsPh.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                AppStrings.phDefinition.tr(),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.measuringUnit.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                AppStrings.phMeasuringUnit.tr(),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.meaningOfReadings.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.phMeaningOfReadingsOnePrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 6.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 6.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfAcidity.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: '• ${AppStrings.phMeaningOfReadingsTwoPrefix.tr()}',
                    children: [
                      TextSpan(
                        text: 4.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 4.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfAcidity.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: '• ${AppStrings.phMeaningOfReadingsThreePrefix.tr()}',
                    children: [
                      TextSpan(
                        text: 2.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 2.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfAcidity.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: '• ${AppStrings.phMeaningOfReadingsFourPrefix.tr()}',
                    children: [
                      TextSpan(
                          text: 1.toWaterQualityName,
                          style: semiPrimarySmallStyle()),
                      TextSpan(
                          text: AppStrings.levelsOfAcidityAndAlkalinity.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: '• ${AppStrings.phMeaningOfReadingsFivePrefix.tr()}',
                    children: [
                      TextSpan(
                        text: 2.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: AppColors.green),
                      ),
                      TextSpan(text: AppStrings.levelsOfAlkalinity.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.phMeaningOfReadingsSixPrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 4.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 4.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfAlkalinity.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: '• ${AppStrings.phMeaningOfReadingsSevenPrefix.tr()}',
                    children: [
                      TextSpan(
                        text: 6.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 6.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfAlkalinity.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          const CustomDivider(),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.whatIsTds.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                AppStrings.tdsDefinition.tr(),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.measuringUnit.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                AppStrings.tdsMeasuringUnit.tr(),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.meaningOfReadings.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.tdsMeaningOfReadingsOnePrefix.tr()}",
                    children: [
                      TextSpan(
                          text: 1.toWaterQualityName,
                          style: semiPrimarySmallStyle()),
                      TextSpan(text: AppStrings.levelsOfTdsDrinkable.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.tdsMeaningOfReadingsTwoPrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 2.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 2.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfTds.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text:
                        "• ${AppStrings.tdsMeaningOfReadingsThreePrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 3.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 3.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfTds.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.tdsMeaningOfReadingsFourPrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 4.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 4.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfTds.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.tdsMeaningOfReadingsFivePrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 5.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 5.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfTds.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.tdsMeaningOfReadingsSixPrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 6.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 6.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.levelsOfTds.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          const CustomDivider(),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.whatIsTemp.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                AppStrings.tempDefinition.tr(),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.measuringUnit.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                AppStrings.tempMeasuringUnit.tr(),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.meaningOfReadings.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.tempMeaningOfReadingsOnePrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 3.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 3.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.temperature.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text: "• ${AppStrings.tempMeaningOfReadingsTwoPrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 2.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 2.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.temperature.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text:
                        "• ${AppStrings.tempMeaningOfReadingsThreePrefix.tr()}",
                    children: [
                      TextSpan(
                          text: 1.toWaterQualityName,
                          style: semiPrimarySmallStyle()),
                      TextSpan(text: AppStrings.temperature.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text:
                        "• ${AppStrings.tempMeaningOfReadingsFourPrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 4.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 4.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.temperature.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(
                    text:
                        "• ${AppStrings.tempMeaningOfReadingsFivePrefix.tr()}",
                    children: [
                      TextSpan(
                        text: 5.toWaterQualityName,
                        style: semiPrimarySmallStyle()
                            .copyWith(color: 5.toWaterQualityColor),
                      ),
                      TextSpan(text: AppStrings.temperature.tr()),
                    ]),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          const CustomDivider(),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.waterQualityIndicators.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                AppStrings.waterQualityIndicatorsContent.tr(),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text(AppStrings.meaningOfParameters.tr()),
            childrenPadding: const EdgeInsets.all(AppValues.small).r,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(text: '• ', children: [
                  TextSpan(
                      text: 1.toWaterQualityName,
                      style: semiPrimarySmallStyle()),
                  TextSpan(text: AppStrings.meaningOfParametersOne.tr()),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: '• ', children: [
                  TextSpan(
                    text: 2.toWaterQualityName,
                    style: semiPrimarySmallStyle()
                        .copyWith(color: 2.toWaterQualityColor),
                  ),
                  TextSpan(text: AppStrings.meaningOfParametersTwo.tr()),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: '• ', children: [
                  TextSpan(
                    text: 3.toWaterQualityName,
                    style: semiPrimarySmallStyle()
                        .copyWith(color: 3.toWaterQualityColor),
                  ),
                  TextSpan(text: AppStrings.meaningOfParametersThree.tr()),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: '• ', children: [
                  TextSpan(
                    text: 4.toWaterQualityName,
                    style: semiPrimarySmallStyle()
                        .copyWith(color: 4.toWaterQualityColor),
                  ),
                  TextSpan(text: AppStrings.meaningOfParametersFour.tr()),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: '• ', children: [
                  TextSpan(
                    text: 5.toWaterQualityName,
                    style: semiPrimarySmallStyle()
                        .copyWith(color: 5.toWaterQualityColor),
                  ),
                  TextSpan(text: AppStrings.meaningOfParametersFive.tr()),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: '• ', children: [
                  TextSpan(
                    text: 6.toWaterQualityName,
                    style: semiPrimarySmallStyle()
                        .copyWith(color: 6.toWaterQualityColor),
                  ),
                  TextSpan(text: AppStrings.meaningOfParametersSix.tr()),
                ]),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

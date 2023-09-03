import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/functions.dart';
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
            title: Text("What is pH?"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                'pH (Potential of Hydrogen) is a crucial water quality parameter that measures the acidity or alkalinity of a liquid. It tells us how acidic or basic a solution is on a scale from 0 to 14, with 7 being neutral.',
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("Measuring Unit:"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                'pH is measured on a scale from 0 to 14, with 7 considered neutral. Values below 7 are acidic, and values above 7 are alkaline.',
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("Meaning of Readings:"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(text: "• 3 and below: Indicates ", children: [
                  TextSpan(
                    text: 'Dangerous',
                    style:
                        semiPrimarySmallStyle().copyWith(color: AppColors.red),
                  ),
                  TextSpan(text: ' levels of acidity.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 5 - 6: Indicates ", children: [
                  TextSpan(
                    text: 'Good',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: AppColors.green),
                  ),
                  TextSpan(text: ' levels of acidity.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 6.5 - 8.5: Indicates ", children: [
                  TextSpan(text: 'Great', style: semiPrimarySmallStyle()),
                  TextSpan(
                      text:
                          ' levels of acidity and alkalinity (Perfect drinkable water).'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 9 - 10.5: Indicates ", children: [
                  TextSpan(
                    text: 'Good',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: AppColors.green),
                  ),
                  TextSpan(text: ' levels of alkalinity.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 11 - 12: Indicates ", children: [
                  TextSpan(
                    text: 'Bad',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: colorFromHexString('#FFC315')),
                  ),
                  TextSpan(text: ' levels of alkalinity.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 3.5 and more: Indicates ", children: [
                  TextSpan(
                    text: 'Dangerous',
                    style:
                        semiPrimarySmallStyle().copyWith(color: AppColors.red),
                  ),
                  TextSpan(text: ' levels of acidity.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          CustomDivider(),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("What is TDS?"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                'TDS (Total Dissolved Solids) measures the total concentration of dissolved substances in water, including minerals, salts, and organic matter. It provides insights into water\'s overall quality and taste.',
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("Measuring Unit:"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                'TDS is measured in parts per million (ppm) or milligrams per liter (mg/L).',
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("Meaning of Readings:"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(text: "• 0 - 140 ppm: Indicates ", children: [
                  TextSpan(text: 'Great', style: semiPrimarySmallStyle()),
                  TextSpan(text: ' levels of TDS (Perfect drinkable water).'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 141 - 200: Indicates ", children: [
                  TextSpan(
                    text: 'Good',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: AppColors.green),
                  ),
                  TextSpan(text: ' levels of TDS.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 201 - 350: Indicates ", children: [
                  TextSpan(
                    text: 'Average',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: AppColors.blackText),
                  ),
                  TextSpan(text: ' levels of TDS.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 351 - 499: Indicates ", children: [
                  TextSpan(
                    text: 'Bad',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: colorFromHexString('#FFC315')),
                  ),
                  TextSpan(text: ' levels of TDS.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 500 -750: Indicates ", children: [
                  TextSpan(
                    text: 'Very Bad',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: colorFromHexString('#FF6B00')),
                  ),
                  TextSpan(text: ' levels of TDS.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 750 and more: Indicates ", children: [
                  TextSpan(
                    text: 'Dangerous',
                    style:
                        semiPrimarySmallStyle().copyWith(color: AppColors.red),
                  ),
                  TextSpan(text: ' levels of TDS.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          CustomDivider(),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("What is Temp?"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                'Water temperature or temp for short, is a fundamental parameter that influences various aspects of aquatic ecosystems and water quality. It can impact the behavior of aquatic organisms and chemical processes in water.',
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("Measuring Unit:"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                'Temperature is measured in degrees Celsius (°C) or degrees Fahrenheit (°F).',
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("Meaning of Readings:"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(text: "• Below 0: Indicates ", children: [
                  TextSpan(
                    text: 'Average',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: AppColors.blackText),
                  ),
                  TextSpan(text: ' temperature.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 0 - 10: Indicates ", children: [
                  TextSpan(
                    text: 'Good',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: AppColors.green),
                  ),
                  TextSpan(text: ' temperature.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 11 - 25: Indicates ", children: [
                  TextSpan(text: 'Great', style: semiPrimarySmallStyle()),
                  TextSpan(text: ' temperature.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• 26 - 35: Indicates ", children: [
                  TextSpan(
                    text: 'Bad',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: colorFromHexString('#FFC315')),
                  ),
                  TextSpan(text: ' temperature.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(text: "• Above 50: Indicates ", children: [
                  TextSpan(
                    text: 'Very Bad',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: colorFromHexString('#FF6B00')),
                  ),
                  TextSpan(text: ' temperature.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          CustomDivider(),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("Water Quality Indicators"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            children: [
              Text(
                'The water quality overview is represented by basic parameters to help you gain quick access to your water supply current quality.',
                style: regularBlackSmallStyle(),
              ),
            ],
          ),
          CustomSpacers.small(),
          ExpansionTile(
            backgroundColor: AppColors.pastelBlue,
            title: Text("Meaning of Parameters:"),
            childrenPadding: EdgeInsets.all(AppValues.small).r,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(text: 'Great', style: semiPrimarySmallStyle()),
                  TextSpan(
                      text:
                          ': Water quality is in ideal condition and is perfect for drinking. '),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Good',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: AppColors.green),
                  ),
                  TextSpan(
                      text:
                          ': Water quality is in suitable condition and is good for drinking.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Average',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: AppColors.blackText),
                  ),
                  TextSpan(
                      text:
                          ': Water quality is in ok condition and is still drinkable.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Bad',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: colorFromHexString('#FFC315')),
                  ),
                  TextSpan(
                      text:
                          ': Water quality is dropping and you should check your water supply.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Very Bad',
                    style: semiPrimarySmallStyle()
                        .copyWith(color: colorFromHexString('#FF6B00')),
                  ),
                  TextSpan(
                      text:
                          ': Water quality is reaching critical levels and you should not use it.'),
                ]),
                style: regularBlackSmallStyle(),
              ),
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                    text: 'Dangerous',
                    style:
                        semiPrimarySmallStyle().copyWith(color: AppColors.red),
                  ),
                  TextSpan(
                      text:
                          ': Water quality is in serious dangerous condition and it could cause serious harm'),
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

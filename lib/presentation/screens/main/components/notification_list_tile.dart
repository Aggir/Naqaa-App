import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/functions.dart';
import 'package:naqaa/domain/entities/notification.dart';
import 'package:naqaa/presentation/blocs/notifications/notifications_cubit.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile(this.notification, {super.key});
  final NotificationEntity notification;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(AppValues.medium).r,
          decoration: BoxDecoration(
              color: notification.isRead
                  ? AppColors.snowWhite
                  : AppColors.pastelBlue.withOpacity(0.5)),
          child: Row(
            children: [
              Container(
                height: AppSizes.s50.r,
                width: AppSizes.s50.r,
                decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(AppValues.circleRadius),
                    border: Border.all(color: AppColors.primary)),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SvgPicture.asset(
                    SvgAssets.notification,
                    height: AppSizes.s25.r,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              CustomSpacers.medium(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: AppSizes.s240.r,
                    child: Text.rich(
                      TextSpan(
                        text: AppStrings.your.tr(),
                        style: regularBluishGraySmallStyle(),
                        children: [
                          TextSpan(
                            text: notification.deviceName,
                            style: regularPrimarySmallStyle(),
                          ),
                          TextSpan(
                            text: AppStrings.waterQualityIsDropping.tr(),
                          ),
                          TextSpan(
                            text: notification.waterQualityName
                                .toLowerCase()
                                .tr(),
                            style: regularBluishGraySmallStyle().copyWith(
                              color: colorFromHexString(
                                  notification.waterQualityHex),
                            ),
                          ),
                          TextSpan(
                              text: ' ${AppStrings.waterQualityLevel.tr()}'),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    '${DateFormat('yyyy-MM-dd  h:mm:ss').format(notification.createdAt)} ${Intl.withLocale(context.locale.languageCode, () => DateFormat('a').format(notification.createdAt))}',
                    style: regularGrayExtraSmallStyle(),
                  )
                ],
              ),
            ],
          ),
        ),
        Positioned.fill(
            child: Material(
          color: AppColors.transparent,
          child: InkWell(
              onTap: notification.isRead
                  ? null
                  : () => BlocProvider.of<NotificationsCubit>(context)
                      .toggleIsRead(notification.id)),
        ))
      ],
    );
  }
}

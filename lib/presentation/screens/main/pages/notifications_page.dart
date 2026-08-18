import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naqaa/app/app_strings.dart';
import 'package:naqaa/app/assets_manager.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/domain/entities/notification.dart';
import 'package:naqaa/presentation/blocs/notifications/notifications_cubit.dart';
import 'package:naqaa/presentation/screens/main/components/notification_list_tile.dart';
import 'package:naqaa/presentation/theme/app_colors.dart';
import 'package:naqaa/presentation/theme/app_theme.dart';
import 'package:naqaa/presentation/theme/text_style_manager.dart';
import 'package:naqaa/presentation/widgets/custom_app_bar.dart';
import 'package:naqaa/presentation/widgets/custom_spacers.dart';
import 'package:naqaa/presentation/widgets/page_container.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    BlocProvider.of<NotificationsCubit>(context).toggleIsSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.basic(title: AppStrings.notifications.tr()),
        body: PageContainer(
            padding: const EdgeInsets.symmetric(
                    vertical: AppValues.large,
                    horizontal: AppValues.mediumSmall)
                .r,
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state.getNotificationsStatus.isLoading) {
                  return _loadingState();
                } else if (state.getNotificationsStatus.isSuccess &&
                    state.notificationsStream != null) {
                  return StreamBuilder(
                    stream: state.notificationsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _loadingState();
                      }
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return _contentState(snapshot.data!);
                      }
                      return _emptyNotifications();
                    },
                  );
                }
                return _emptyNotifications();
              },
            )));
  }

  Widget _contentState(List<NotificationEntity> notifications) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          // color: AppColors.snowWhite,

          borderRadius: BorderRadius.circular(AppValues.small.r)),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        // separatorBuilder: (context, index) => Padding(
        //     padding: const EdgeInsets.symmetric(
        //             horizontal: AppValues.medium,
        //             vertical: AppValues.extraSmall)
        //         .r,
        //     child: const CustomDivider()),
        shrinkWrap: true,
        itemCount: notifications.length,
        // padding: const EdgeInsets.symmetric(horizontal: AppSizes.s16).r,
        itemBuilder: (context, index) => NotificationListTile(
          notifications[index],
        ),
      ),
    );
  }

  Widget _loadingState() {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _emptyNotifications() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            SvgAssets.notification,
            height: 100,
            colorFilter:
                const ColorFilter.mode(AppColors.pastelBlue, BlendMode.srcIn),
          ),
          CustomSpacers.medium(),
          Text(
            AppStrings.noActivityYet.tr(),
            style: regularDarkGrayMediumStyle(),
          ),
          CustomSpacers.small(),
          Text(
            AppStrings.yourNotificationsWillAppearHere.tr(),
            style: regularBluishGraySmallStyle(),
          ),
        ],
      ),
    );
  }
}

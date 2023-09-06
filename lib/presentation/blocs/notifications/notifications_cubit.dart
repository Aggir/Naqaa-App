import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:naqaa/app/di/dependency_injection.dart';
import 'package:naqaa/app/enums/status_enum.dart';
import 'package:naqaa/domain/entities/notification.dart';
import 'package:naqaa/domain/usecases/get_notifications_usecase.dart';
import 'package:naqaa/domain/usecases/read_notification_usecase.dart';
import 'package:naqaa/domain/usecases/toggle_seen_notifications_usecase.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());

  Stream<int> unseenNotificationsStream() {
    return state.notificationsStream?.asyncExpand((event) => Stream.value(
            event.where((element) => !element.isSeen).toList().length)) ??
        Stream.value(0);
  }

  void getNotifications() async {
    emit(state.copyWith(getNotificationsStatus: Status.loading));
    initGetNotifications();
    (await instance<GetNotificationsUsecase>().execute(null)).fold(
        (failure) => emit(state.copyWith(
            getNotificationsStatus: Status.failure,
            getNotificationsErrorMessage: failure.message)), (notifications) {
      emit(state.copyWith(
          getNotificationsStatus: Status.success,
          notificationsStream: notifications));
    });
  }

  void toggleIsSeen() async {
    // if(state.notificationsStream.)
    initSeenNotifications();
    (await instance<ToggleSeenNotificationsUsecase>().execute(null))
        .fold((l) => null, (r) => null);
  }

  void toggleIsRead(String notificationId) async {
    emit(state.copyWith(toggleIsReadStatus: Status.loading));
    initReadNotification();
    (await instance<ReadNotificationUsecase>().execute(notificationId)).fold(
        (failure) => emit(state.copyWith(
            toggleIsReadStatus: Status.failure,
            toggleIsReadErrorMessage: failure.message)),
        (_) => emit(state.copyWith(toggleIsReadStatus: Status.success)));
  }
}

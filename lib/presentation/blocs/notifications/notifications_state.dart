part of 'notifications_cubit.dart';

class NotificationsState extends Equatable {
  final Status getNotificationsStatus;
  final String? getNotificationsErrorMessage;
  final Stream<List<NotificationEntity>>? notificationsStream;
  // final Stream<int>? unseenNotificationsCount;
  final Status toggleIsReadStatus;
  final String? toggleIsReadErrorMessage;

  const NotificationsState({
    this.getNotificationsStatus = Status.initial,
    this.getNotificationsErrorMessage,
    this.notificationsStream,
    // this.unseenNotificationsCount,
    this.toggleIsReadStatus = Status.initial,
    this.toggleIsReadErrorMessage,
  });

  @override
  List<Object?> get props => [
        getNotificationsStatus,
        getNotificationsErrorMessage,
        notificationsStream,
        // unseenNotificationsCount,
        toggleIsReadStatus,
        toggleIsReadErrorMessage,
      ];

  NotificationsState copyWith({
    Status? getNotificationsStatus,
    String? getNotificationsErrorMessage,
    Stream<List<NotificationEntity>>? notificationsStream,
    // Stream<int>? unseenNotificationsCount,
    Status? toggleIsReadStatus,
    String? toggleIsReadErrorMessage,
  }) {
    return NotificationsState(
      getNotificationsStatus:
          getNotificationsStatus ?? this.getNotificationsStatus,
      getNotificationsErrorMessage:
          getNotificationsErrorMessage ?? this.getNotificationsErrorMessage,
      notificationsStream: notificationsStream ?? this.notificationsStream,
      // unseenNotificationsCount:
      //     unseenNotificationsCount ?? this.unseenNotificationsCount,
      toggleIsReadStatus: toggleIsReadStatus ?? this.toggleIsReadStatus,
      toggleIsReadErrorMessage:
          toggleIsReadErrorMessage ?? this.toggleIsReadErrorMessage,
    );
  }
}

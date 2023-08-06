part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final Status fetchingDataStatus;
  final String? fetchingDataMessage;

  final Status editProfileStatus;
  final String? editProfileMessage;
  const EditProfileState({
    this.fetchingDataStatus = Status.initial,
    this.fetchingDataMessage,
    this.editProfileStatus = Status.initial,
    this.editProfileMessage,
  });

  @override
  List<Object?> get props => [
        fetchingDataStatus,
        fetchingDataMessage,
        editProfileStatus,
        editProfileMessage
      ];
}

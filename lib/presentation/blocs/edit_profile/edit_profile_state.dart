part of 'edit_profile_cubit.dart';

class EditProfileState extends Equatable {
  final Status editPictureStatus;
  final String? editPictureMessage;
  final File? selectedPicture;
  const EditProfileState({
    this.editPictureStatus = Status.initial,
    this.editPictureMessage,
    this.selectedPicture,
  });

  @override
  List<Object?> get props =>
      [editPictureStatus, editPictureMessage, selectedPicture];

  EditProfileState copyWith({
    Status? editPictureStatus,
    String? editPictureMessage,
    File? selectedPicture,
  }) {
    return EditProfileState(
      editPictureStatus: editPictureStatus ?? this.editPictureStatus,
      editPictureMessage: editPictureMessage ?? this.editPictureMessage,
      selectedPicture: selectedPicture ?? this.selectedPicture,
    );
  }
}

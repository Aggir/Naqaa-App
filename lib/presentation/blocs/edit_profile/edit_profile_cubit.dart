import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naqaa/app/constants.dart';
import 'package:naqaa/app/enum.dart';
import 'package:naqaa/domain/entities/user.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(const EditProfileState());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  init(UserEntity? user) {
    if (user != null) {
      emailController.text = user.email;
      nameController.text = user.name;
      genderController.text = user.genderId;
      dateOfBirthController.text = user.dateOfBirth != null
          ? DateFormat('dd/MM/yyyy').format(user.dateOfBirth!)
          : Constants.empty;
    }
  }

  imagePickerMode(bool isCamera) {
    if (isCamera) {
      _takePicture();
    } else {
      _chooseFromGallery();
    }
  }

  _chooseFromGallery() async {
    emit(state.copyWith(editPictureStatus: Status.loading));
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70, maxHeight: 500);
    if (image != null) {
      final File imageFile = File(image.path);
      emit(state.copyWith(
          editPictureStatus: Status.success, selectedPicture: imageFile));
    } else {
      emit(const EditProfileState());
    }
  }

  _takePicture() async {
    emit(state.copyWith(editPictureStatus: Status.loading));
    final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 70, maxHeight: 500);
    if (image != null) {
      final File imageFile = File(image.path);
      emit(state.copyWith(
          editPictureStatus: Status.success, selectedPicture: imageFile));
    } else {
      emit(const EditProfileState());
    }
  }

  String get name => nameController.text;
  String get gender => genderController.text;
  String get dateOfBirth => dateOfBirthController.text;

  bool get isFormValid => formKey.currentState?.validate() ?? false;
}

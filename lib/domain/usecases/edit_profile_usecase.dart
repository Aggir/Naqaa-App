import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

import '../entities/user.dart';

class EditProfileUsecase
    implements BaseUsecase<EditProfileUsecaseInput, UserEntity> {
  final Repository _repository;
  const EditProfileUsecase(this._repository);
  @override
  Future<Either<Failure, UserEntity>> execute(
      EditProfileUsecaseInput input) async {
    return await _repository.editProfile(EditProfileRequest(
        newUser: input.newUser, pickedImage: input.pickedImage));
  }
}

class EditProfileUsecaseInput {
  final UserEntity newUser;
  final File? pickedImage;
  const EditProfileUsecaseInput({required this.newUser, this.pickedImage});
}

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
        fullName: input.fullName,
        genderId: input.genderId,
        dateOfBirth: input.dateOfBirth));
  }
}

class EditProfileUsecaseInput {
  final String fullName;
  final String? genderId;
  final int? dateOfBirth;
  EditProfileUsecaseInput({
    required this.fullName,
    this.genderId,
    this.dateOfBirth,
  });
}

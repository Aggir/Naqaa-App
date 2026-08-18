import 'package:dartz/dartz.dart';

import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class EditDeviceNameUsecase
    implements BaseUsecase<EditDeviceNameUsecaseInput, void> {
  final Repository _repository;

  EditDeviceNameUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(
      EditDeviceNameUsecaseInput input) async {
    return await _repository.editDeviceName(EditDeviceNameRequest(
      newName: input.newName,
      id: input.macAddress,
    ));
  }
}

class EditDeviceNameUsecaseInput {
  final String newName;
  final String macAddress;

  EditDeviceNameUsecaseInput({
    required this.newName,
    required this.macAddress,
  });
}

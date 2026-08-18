import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class AddDeviceUsecase implements BaseUsecase<AddDeviceUsecaseInput, void> {
  final Repository _repository;

  AddDeviceUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(AddDeviceUsecaseInput input) async {
    return await _repository
        .addDevice(AddDeviceRequest(name: input.name, id: input.macAddress));
  }
}

class AddDeviceUsecaseInput {
  final String name;
  final String macAddress;

  AddDeviceUsecaseInput({
    required this.name,
    required this.macAddress,
  });
}

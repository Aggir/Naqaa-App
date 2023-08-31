import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class DeleteDeviceUsecase implements BaseUsecase<String, void> {
  final Repository _repository;

  DeleteDeviceUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String macAddress) async {
    return await _repository.deleteDevice(macAddress);
  }
}

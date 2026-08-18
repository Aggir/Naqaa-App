import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/entities/device.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class GetDevicesUsecase
    implements BaseUsecase<void, Stream<List<DeviceEntity>>> {
  final Repository _repository;

  GetDevicesUsecase(this._repository);

  @override
  Future<Either<Failure, Stream<List<DeviceEntity>>>> execute(
      void input) async {
    return await _repository.getDevices();
  }
}

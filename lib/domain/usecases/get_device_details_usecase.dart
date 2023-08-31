import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/entities/device_details.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class GetDeviceDetailsUsecase
    implements BaseUsecase<String, Stream<DeviceDetailsEntity>> {
  final Repository _repository;
  GetDeviceDetailsUsecase(this._repository);

  @override
  Future<Either<Failure, Stream<DeviceDetailsEntity>>> execute(
      String macAddress) async {
    return await _repository.getDeviceDetails(macAddress);
  }
}

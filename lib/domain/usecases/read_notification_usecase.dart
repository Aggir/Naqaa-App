import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class ReadNotificationUsecase implements BaseUsecase<String, void> {
  final Repository _repository;

  ReadNotificationUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(String notificationId) async {
    return await _repository.readNotification(notificationId);
  }
}

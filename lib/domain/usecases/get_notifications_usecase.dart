import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/entities/notification.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class GetNotificationsUsecase
    implements BaseUsecase<void, Stream<List<NotificationEntity>>> {
  final Repository _repository;

  GetNotificationsUsecase(this._repository);

  @override
  Future<Either<Failure, Stream<List<NotificationEntity>>>> execute(
      void input) async {
    return await _repository.getUserNotifications();
  }
}

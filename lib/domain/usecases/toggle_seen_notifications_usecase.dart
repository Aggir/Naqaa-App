import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class ToggleSeenNotificationsUsecase implements BaseUsecase<void, void> {
  final Repository _repository;

  ToggleSeenNotificationsUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(void input) async {
    return await _repository.seenNotifications();
  }
}

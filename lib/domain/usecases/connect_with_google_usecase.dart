import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

import '../entities/user.dart';

class ConnectWithGoogleUsecase implements BaseUsecase<void, UserEntity> {
  final Repository _repository;
  const ConnectWithGoogleUsecase(this._repository);
  @override
  Future<Either<Failure, UserEntity>> execute(input) async {
    return _repository.connectWithGoogle();
  }
}

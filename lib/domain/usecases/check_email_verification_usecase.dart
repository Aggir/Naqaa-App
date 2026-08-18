import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class CheckEmailVerificationUsecase implements BaseUsecase<String, bool> {
  final Repository _repository;

  CheckEmailVerificationUsecase(this._repository);
  @override
  Future<Either<Failure, bool>> execute(String email) async {
    return await _repository.checkEmailVerification(email);
  }
}

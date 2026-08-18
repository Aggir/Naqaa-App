import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class SendEmailVerificationUsecase implements BaseUsecase<String, void> {
  final Repository _repository;

  SendEmailVerificationUsecase(this._repository);

  @override
  Future<Either<Failure, void>> execute(String email) async {
    return await _repository.sendEmailVerification(email);
  }
}

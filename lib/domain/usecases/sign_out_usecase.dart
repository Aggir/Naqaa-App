import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class SignOutUsecase implements BaseUsecase<void, void> {
  final Repository _repository;
  const SignOutUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(input) async {
    return await _repository.signOut();
  }
}

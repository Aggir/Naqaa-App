import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/domain/repositories/auth_repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class SignOutUsecase implements BaseUsecase<void, void> {
  final AuthRepository _repository;
  const SignOutUsecase(this._repository);
  @override
  Future<Either<Failure, void>> execute(input) async {
    return _repository.signOut();
  }
}

import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/repositories/auth_repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class SignUpUsecase implements BaseUsecase<SignUpUsecaseInput, String> {
  final AuthRepository _repository;
  const SignUpUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(SignUpUsecaseInput input) async {
    return _repository.signUp(SignUpRequest(
        fullName: input.fullName,
        emailAddress: input.emailAddress,
        password: input.password));
  }
}

class SignUpUsecaseInput {
  final String fullName;
  final String emailAddress;
  final String password;

  const SignUpUsecaseInput({
    required this.fullName,
    required this.emailAddress,
    required this.password,
  });
}

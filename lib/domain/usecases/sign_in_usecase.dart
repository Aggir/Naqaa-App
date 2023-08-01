import 'package:dartz/dartz.dart';
import 'package:naqaa/app/failure.dart';
import 'package:naqaa/data/requests/requests.dart';
import 'package:naqaa/domain/repositories/auth_repository.dart';
import 'package:naqaa/domain/usecases/base_usecase.dart';

class SignInUsecase implements BaseUsecase<SignInUsecaseInput, String> {
  final AuthRepository _repository;
  const SignInUsecase(this._repository);
  @override
  Future<Either<Failure, String>> execute(SignInUsecaseInput input) async {
    return _repository.signIn(SignInRequest(
        emailAddress: input.emailAddress, password: input.password));
  }
}

class SignInUsecaseInput {
  final String emailAddress;
  final String password;

  const SignInUsecaseInput({
    required this.emailAddress,
    required this.password,
  });
}

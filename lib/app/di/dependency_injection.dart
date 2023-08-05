import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:naqaa/app/helpers/app_service.dart';
import 'package:naqaa/data/datasources/remote/firebase_api.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/repositories/auth_repository_impl.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/change_password_usecase.dart';
import 'package:naqaa/domain/usecases/index.dart';
import 'package:naqaa/domain/usecases/connect_with_google_usecase.dart';
import 'package:naqaa/domain/usecases/is_signed_in_usecase.dart';
import 'package:naqaa/domain/usecases/sign_out_usecase.dart';
import 'package:naqaa/presentation/blocs/auth/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Shared Preferences instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // App service instance
  instance.registerLazySingleton<AppService>(
      () => AppService(instance<SharedPreferences>()));

  // remote FirebaseAuth instance
  instance.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // remote database instance (Firebase Package)
  instance.registerLazySingleton<RemoteDataSource>(
      () => FirebaseApi(instance<FirebaseAuth>()));

  // Repositories
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance<RemoteDataSource>()));
  // Auth Cubit
  instance.registerFactory(() => AuthCubit());
}

void initSendResetInstructions() async {
  if (!GetIt.I.isRegistered<SendResetInstructionsUsecase>()) {
    instance.registerFactory<SendResetInstructionsUsecase>(
        () => SendResetInstructionsUsecase(instance<Repository>()));
  }
}

void initSignIn() async {
  if (!GetIt.I.isRegistered<SignInUsecase>()) {
    instance.registerFactory<SignInUsecase>(
        () => SignInUsecase(instance<Repository>()));
  }
}

void initConnectWithGoogle() async {
  if (!GetIt.I.isRegistered<ConnectWithGoogleUsecase>()) {
    instance.registerFactory<ConnectWithGoogleUsecase>(
        () => ConnectWithGoogleUsecase(instance<Repository>()));
  }
}

void initSignOut() async {
  if (!GetIt.I.isRegistered<SignOutUsecase>()) {
    instance.registerFactory<SignOutUsecase>(
        () => SignOutUsecase(instance<Repository>()));
  }
}

void initSignUp() async {
  if (!GetIt.I.isRegistered<SignUpUsecase>()) {
    instance.registerFactory<SignUpUsecase>(
        () => SignUpUsecase(instance<Repository>()));
  }
}

void initIsSignedIn() async {
  if (!GetIt.I.isRegistered<IsSignedInUsecase>()) {
    instance.registerFactory<IsSignedInUsecase>(
        () => IsSignedInUsecase(instance<Repository>()));
  }
}

void initChangePassword() async {
  if (!GetIt.I.isRegistered<ChangePasswordUsecase>()) {
    instance.registerFactory<ChangePasswordUsecase>(
        () => ChangePasswordUsecase(instance<Repository>()));
  }
}

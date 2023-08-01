import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:naqaa/data/datasources/remote/firebase_api.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/repositories/auth_repository_impl.dart';
import 'package:naqaa/domain/repositories/auth_repository.dart';
import 'package:naqaa/domain/usecases/index.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // Shared Preferences instance
  // final sharedPrefs = await SharedPreferences.getInstance();

  // instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // app prefs instance
  // instance.registerLazySingleton<AppPreferences>(
  //     () => AppPreferences(instance<SharedPreferences>()));

  // remote FirebaseAuth instance
  instance.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // remote database instance (Firebase Package)
  instance.registerLazySingleton<RemoteDataSource>(
      () => FirebaseApi(instance<FirebaseAuth>()));

  // Repositories
  instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance<RemoteDataSource>()));
}

void initSendResetInstructions() async {
  if (!GetIt.I.isRegistered<SendResetInstructionsUsecase>()) {
    instance.registerFactory<SendResetInstructionsUsecase>(
        () => SendResetInstructionsUsecase(instance<AuthRepository>()));
  }
}

void initSignIn() async {
  if (!GetIt.I.isRegistered<SignInUsecase>()) {
    instance.registerFactory<SignInUsecase>(
        () => SignInUsecase(instance<AuthRepository>()));
  }
}

void initSignUp() async {
  if (!GetIt.I.isRegistered<SignUpUsecase>()) {
    instance.registerFactory<SignUpUsecase>(
        () => SignUpUsecase(instance<AuthRepository>()));
  }
}

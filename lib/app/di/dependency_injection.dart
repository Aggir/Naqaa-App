import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:naqaa/app/helpers/app_service.dart';
import 'package:naqaa/data/datasources/remote/firebase_api.dart';
import 'package:naqaa/data/datasources/remote_datasource.dart';
import 'package:naqaa/data/repositories/repository_impl.dart';
import 'package:naqaa/domain/repositories/repository.dart';
import 'package:naqaa/domain/usecases/add_device_usecase.dart';
import 'package:naqaa/domain/usecases/change_password_usecase.dart';
import 'package:naqaa/domain/usecases/edit_device_name_usecase.dart';
import 'package:naqaa/domain/usecases/edit_profile_usecase.dart';
import 'package:naqaa/domain/usecases/get_device_details_usecase.dart';
import 'package:naqaa/domain/usecases/get_devices_usecase.dart';
import 'package:naqaa/domain/usecases/index.dart';
import 'package:naqaa/domain/usecases/connect_with_google_usecase.dart';
import 'package:naqaa/domain/usecases/is_signed_in_usecase.dart';
import 'package:naqaa/domain/usecases/sign_out_usecase.dart';
import 'package:naqaa/presentation/blocs/user/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_scan/wifi_scan.dart';

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

  // remote FirebaseFirestore instance
  instance.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // remote FirebaseDatabase instance
  instance
      .registerLazySingleton<FirebaseDatabase>(() => FirebaseDatabase.instance);

  // remote WiFi-Scan instance
  instance.registerLazySingleton<WiFiScan>(() => WiFiScan.instance);

  // remote database instance (Firebase Package)
  instance.registerLazySingleton<RemoteDataSource>(() => FirebaseApi(
      instance<FirebaseAuth>(),
      instance<FirebaseFirestore>(),
      instance<FirebaseDatabase>()));

  // Repositories
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance<RemoteDataSource>()));
  // Auth Cubit
  instance.registerFactory(() => UserCubit());
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

void initEditProfile() async {
  if (!GetIt.I.isRegistered<EditProfileUsecase>()) {
    instance.registerFactory<EditProfileUsecase>(
        () => EditProfileUsecase(instance<Repository>()));
  }
}

void initAddDevice() async {
  if (!GetIt.I.isRegistered<AddDeviceUsecase>()) {
    instance.registerFactory<AddDeviceUsecase>(
        () => AddDeviceUsecase(instance<Repository>()));
  }
}

void initGetDevices() async {
  if (!GetIt.I.isRegistered<GetDevicesUsecase>()) {
    instance.registerFactory<GetDevicesUsecase>(
        () => GetDevicesUsecase(instance<Repository>()));
  }
}

void initEditDeviceName() async {
  if (!GetIt.I.isRegistered<EditDeviceNameUsecase>()) {
    instance.registerFactory<EditDeviceNameUsecase>(
        () => EditDeviceNameUsecase(instance<Repository>()));
  }
}

void initGetDeviceDetails() async {
  if (!GetIt.I.isRegistered<GetDeviceDetailsUsecase>()) {
    instance.registerFactory<GetDeviceDetailsUsecase>(
        () => GetDeviceDetailsUsecase(instance<Repository>()));
  }
}

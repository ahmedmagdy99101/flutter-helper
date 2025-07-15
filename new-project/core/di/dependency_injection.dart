import '../constants/api_constants.dart';
import '../network/app_interceptor.dart';

import '../network/dio_consumer.dart';
import 'dependency_injection_imports.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  //! DIO CONFIGURATIONS
  getIt.registerSingleton<Dio>(
    Dio(
      BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          connectTimeout: const Duration(minutes: 2),
          receiveTimeout: const Duration(minutes: 2),
        )
        ..followRedirects = false
        ..receiveDataWhenStatusError = true,
    ),
  );

  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio:
          getIt.get<Dio>()
            ..interceptors.add(AppInterceptors(dio: getIt.get<Dio>()))
            ..interceptors.addAll([
              if (kDebugMode)
                PrettyDioLogger(
                  request: true,
                  requestBody: true,
                  responseHeader: true,
                  responseBody: true,
                  error: true,
                  compact: true,
                ),
            ]),
    ),
  );
  //? ==================== LOGIN =========================
  // getIt.registerLazySingleton<LoginRemoteDS>(
  //   () => LoginRemoteDSImpl(apiConsumer: getIt.get<DioConsumer>()),
  // );
  // getIt.registerLazySingleton<LoginRepo>(
  //   () => LoginRepoImpl(loginRemoteDS: getIt.get<LoginRemoteDS>()),
  // );
  // getIt.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(loginRepo: getIt.get<LoginRepo>()),
  // );
  // getIt.registerFactory<LoginCubit>(
  //   () => LoginCubit(loginUseCase: getIt.get<LoginUseCase>()),
  // );

  //! external
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  FlutterSecureStorage? secureStorage = const FlutterSecureStorage();
  getIt.registerFactory(() => sharedPreferences);
  getIt.registerLazySingleton(() => secureStorage);
}

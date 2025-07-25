import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/routing/routes.dart';
import '../../../core/storage/cache_helper.dart';
import '../constants/api_constants.dart';
import '../constants/storage_constants.dart';
import 'status_code.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors({required this.dio});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? authToken = await AppSecurePreference.getString(
      key: StorageConstants.accessToken,
    );
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint("err.response?.statusCode ${err.response?.statusCode}");
    if (err.response?.statusCode == StatusCode.unauthorized) {
      String? accessToken = await AppSecurePreference.getString(
        key: StorageConstants.accessToken,
      );
      String? refreshToken = AppSharedPreferences.getString(
        key: StorageConstants.refreshToken,
      );
      debugPrint(accessToken);
      debugPrint(refreshToken);
      if (refreshToken != null && refreshToken.isNotEmpty) {
        dio.options.baseUrl = ApiConstants.baseUrl;
        await dio
            .post(ApiConstants.refreshToken, data: {"token": refreshToken})
            .then((value) async {
              debugPrint("value : $value");
              String token = value.data["accessToken"];

              await AppSecurePreference.setString(
                value: token,
                key: StorageConstants.accessToken,
              );
            });
        accessToken = await AppSecurePreference.getString(
          key: StorageConstants.accessToken,
        );
        err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
        return handler.resolve(await dio.fetch(err.requestOptions));
      }
    } else if (err.response?.statusCode == StatusCode.forbidden) {
      router.go(Routes.login);
    }
    super.onError(err, handler);
  }
}

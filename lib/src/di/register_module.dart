import 'package:dio/dio.dart';
import 'package:fiteats/src/core/config/app_config.dart';
import 'package:fiteats/src/core/constants/app_constants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  /// Dio HTTP client
  @lazySingleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
        sendTimeout: AppConstants.apiTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    if (AppConfig.isDevelopment) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }

    return dio;
  }

  /// SharedPreferences
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  /// Hive box
  @preResolve
  Future<Box<dynamic>> get hiveBox async {
    if (!Hive.isBoxOpen(AppConstants.hiveBoxName)) {
      return await Hive.openBox(AppConstants.hiveBoxName);
    }
    return Hive.box(AppConstants.hiveBoxName);
  }
}

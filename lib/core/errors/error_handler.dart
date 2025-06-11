import 'dart:developer' as dev;
import 'package:base_template/core/errors/app_error.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:base_template/core/errors/app_error_catalog.dart';
import 'package:base_template/core/errors/app_error_report.dart';
import 'app_exception.dart';

Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    // Primero validamos que haya conexión
    final connectivity = await Connectivity().checkConnectivity();
    final check = connectivity.firstWhere(
      (element) =>
          element == ConnectivityResult.mobile ||
          element == ConnectivityResult.wifi,
      orElse: () => ConnectivityResult.none,
    );
    if (check == ConnectivityResult.none) {
      throw AppErrorCatalog.noInternetConnection;
    }

    return await apiCall();
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw AppErrorCatalog.timeout;
    }

    final statusCode = e.response?.statusCode ?? 0;
    switch (statusCode) {
      case 401:
        throw AppErrorCatalog.unauthorized;
      case 403:
        throw AppErrorCatalog.forbidden;
      case 500:
        throw AppErrorCatalog.serverError;
      default:
        throw AppErrorCatalog.unknown(stackTrace: e.stackTrace);
    }
  } on FormatException catch (e) {
    throw ParsingException(message: e.message);
  } on TypeError catch (e) {
    throw ParsingException(stackTrace: e.stackTrace);
    // } on AppException catch (e) {
    //   // Aquí no debería lanzar UnknownException
    //   rethrow; // ← permite propagar sin alterar
  } catch (e, stack) {
    if (e is AppError) {
      throw AppError(
        code: e.code,
        title: e.title,
        message: e.message,
      );
    }
    throw UnknownException(stackTrace: stack);
  }
}

void _reportError(AppErrorReport error) {
  dev.log("[ERROR] ${error.code}: ${error.developerMessage}",
      error: error.developerMessage, stackTrace: error.stackTrace);
  // También podrías enviarlo a Firebase, Sentry, consola, archivo, etc.
}

import 'dart:developer' as dev;
import 'package:dio/dio.dart';

import 'package:base_template/core/errors/error_codes.dart';
import 'package:base_template/core/utils/global_functions.dart';
import 'package:base_template/presentation/widgets/full_screen_error.dart';
import 'package:base_template/core/errors/app_error.dart';
import 'package:base_template/core/errors/error_reporter_service.dart';
import 'package:base_template/core/errors/app_error_catalog.dart';
import 'package:base_template/core/errors/app_error_report.dart';
import 'app_exception.dart';

final reporter = ErrorReporterService();

Future<T> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    // Primero validamos que haya conexión

    final isConnected = await GlobalFunctions.isConnectedToNetwork();
    if (!isConnected) {
      throw AppErrorCatalog.noInternetConnection;
    }

    return await apiCall();
  } on DioException catch (e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      throw AppErrorCatalog.timeout;
    }

    final statusCode = e.response?.statusCode ?? 0;
    reporter.report(
      code: statusCode.toString(),
      title: 'DioException',
      message: e.toString(),
      messageDev:
          '-|Response:|- ${e.response} -|Request:|- ${e.requestOptions.baseUrl}${e.requestOptions.path} -|Request data:|- ${e.requestOptions.data} -|Request método:|- ${e.requestOptions.method}',
      stackTrace: e.stackTrace,
      screen: 'Unknown',
    );
    switch (statusCode) {
      case 400:
        throw AppErrorCatalog.badRequest;
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
    reporter.report(
      code: ErrorCodes.parsingException,
      title: 'FormatException',
      message: e.toString(),
      messageDev: e.source ?? '',
      stackTrace: e.source,
      screen: 'Unknown',
    );
    throw ParsingException(message: e.message);
  } on TypeError catch (e) {
    reporter.report(
      code: ErrorCodes.parsingException,
      title: 'TypeError',
      message: e.toString(),
      messageDev: '',
      stackTrace: e.stackTrace,
      screen: 'Unknown',
    );
    throw ParsingException(stackTrace: e.stackTrace);
    // } on AppException catch (e) {
    //   // Aquí no debería lanzar UnknownException
    //   rethrow; // ← permite propagar sin alterar
  } catch (e, stack) {
    final error = e is AppError
        ? e
        : AppError(
            code: ErrorCodes.unknownException,
            title: 'Error desconocido',
            message: e.toString(),
          );
    reporter.report(
      code: error.code,
      title: error.title,
      message: error.message,
      messageDev: error.messageDev ?? '',
      stackTrace: error.stackTrace ?? stack,
      screen: 'Unknown',
    );
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

void handleCatchError({
  required Function function,
  String title = 'Error',
  String message = 'Lo sentimos, ocurrió un error inesperado.',
  String messageDev = '',
  String screen = 'Unknown',
  String code = ErrorCodes.unknownException,
  StackTrace? stackTrace,
}) {
  try {
    function();
  } catch (e) {
    FullScreenError(
      title: title,
      message: message,
      code: code,
    );
    reporter.report(
      code: code,
      title: title,
      message: message,
      messageDev: '$messageDev : ${e.toString()}',
      stackTrace: e is StackTrace ? e : stackTrace,
      screen: screen,
    );
  }
}

void _reportError(AppErrorReport error) {
  dev.log("[ERROR] ${error.code}: ${error.developerMessage}",
      error: error.developerMessage, stackTrace: error.stackTrace);
  // También podrías enviarlo a Firebase, Sentry, consola, archivo, etc.
}

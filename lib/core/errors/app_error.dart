import 'package:base_template/core/errors/app_exception.dart';

class AppError extends AppException {
  AppError({
    required super.code,
    required super.title,
    required super.message,
    super.stackTrace,
  });
}

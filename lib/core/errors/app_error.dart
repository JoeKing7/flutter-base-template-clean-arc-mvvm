// import 'package:base_template/core/errors/app_exception.dart';

class AppError {
  final String code;
  final String title;
  final String message;
  final String? messageDev;
  final StackTrace? stackTrace;

  AppError({
    required this.code,
    required this.title,
    required this.message,
    this.messageDev,
    this.stackTrace,
  });
}

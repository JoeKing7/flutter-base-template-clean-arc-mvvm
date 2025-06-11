import 'package:base_template/core/errors/app_error.dart';
import 'package:base_template/core/errors/error_codes.dart';

// abstract class AppException implements Exception {
//   final String code;
//   final String title;
//   final String message;
//   final StackTrace? stackTrace;

//   AppException({
//     required this.code,
//     required this.title,
//     required this.message,
//     this.stackTrace,
//   });

//   @override
//   String toString() => '$runtimeType [$code]: $message';
// }

class ParsingException extends AppError {
  ParsingException({
    super.message = "Error al interpretar los datos recibidos.",
    super.messageDev,
    super.stackTrace,
  }) : super(
          code: ErrorCodes.parsingException,
          title: "Error de formato",
        );
}

class UnknownException extends AppError {
  UnknownException({
    super.message = "Ha ocurrido un error inesperado.",
    super.messageDev,
    super.stackTrace,
  }) : super(
          code: ErrorCodes.unknownException,
          title: "Error desconocido",
        );
}

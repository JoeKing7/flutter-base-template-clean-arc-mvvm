import 'package:base_template/core/errors/app_exception.dart';

class Failure {
  final String title;
  final String message;
  final String code;

  Failure({required this.code, required this.title, required this.message});

  factory Failure.fromException(AppException e) => Failure(
        code: e.code,
        title: e.title,
        message: e.message,
      );
}

// class NetworkFailure extends Failure {
//   NetworkFailure() : super("Sin conexión a internet", 'NET_001');
// }

// class UnauthorizedFailure extends Failure {
//   UnauthorizedFailure() : super("No autorizado", 'AUT_401');
// }

// class ServerFailure extends Failure {
//   ServerFailure() : super("Error del servidor", 'AOW_500');
// }

// class UnknownFailure extends Failure {
//   UnknownFailure(super.message, super.code);
// }

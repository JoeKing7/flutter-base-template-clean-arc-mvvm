abstract class AppException implements Exception {
  final String code;
  final String title;
  final String message;
  final StackTrace? stackTrace;

  AppException({
    required this.code,
    required this.title,
    required this.message,
    this.stackTrace,
  });

  @override
  String toString() => '$runtimeType [$code]: $message';
}

class ParsingException extends AppException {
  ParsingException({
    super.message = "Error al interpretar los datos recibidos.",
    super.stackTrace,
  }) : super(
          code: "GENx002",
          title: "Error de formato",
        );
}

class UnknownException extends AppException {
  UnknownException({
    super.message = "Ha ocurrido un error inesperado.",
    super.stackTrace,
  }) : super(
          code: "GENx001",
          title: "Error desconocido",
        );
}

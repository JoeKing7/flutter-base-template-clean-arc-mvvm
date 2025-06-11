class AppErrorReport {
  final String code;
  final String userMessage;
  final String developerMessage;
  final String? file;
  final int? line;
  final StackTrace? stackTrace;

  AppErrorReport({
    required this.code,
    required this.userMessage,
    required this.developerMessage,
    this.file,
    this.line,
    this.stackTrace,
  });
}

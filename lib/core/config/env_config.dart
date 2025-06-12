import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  final String apiBaseUrl = dotenv.env['API_BASE_URL'] ?? '';
  final String environment = dotenv.env['ENVIRONMENT'] ?? 'pro';
  final String appVersion = dotenv.env['APP_VERSION'] ?? '1.0.0';
  final String sentryDns = dotenv.env['SENTRY_DNS'] ?? '';
  final String cipherKey = dotenv.env['KEY'] ?? '';
  final String cipherIv = dotenv.env['IV'] ?? '';

  bool get isDev => environment == 'dev';
}

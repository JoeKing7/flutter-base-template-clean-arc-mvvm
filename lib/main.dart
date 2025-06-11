import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:base_template/config/app_pages.dart';
import 'package:base_template/config/bindings/initial_bindings.dart';
import 'package:base_template/core/config/app_config.dart';
import 'package:base_template/core/database/isar_db_service.dart';
import 'package:base_template/core/firebase/firebase_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // await Firebase.initializeApp();

  // await IsarDBService.init(); // Inicia base de datos local
  // await FirebaseNotificationService().initialize(); // Notificaciones Push

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppConfig config = AppConfig();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter APP',
      initialBinding: InitialBindings(),
      theme: config.appTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}

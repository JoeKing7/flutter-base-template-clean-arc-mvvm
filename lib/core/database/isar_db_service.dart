import 'package:isar/isar.dart';

class IsarDBService {
  final Isar db;
  IsarDBService(this.db);
  static Future<void> init() async {
    // Open the Isar database
    await Isar.open(
      [/* Add your Isar schemas here */],
      directory: 'isar_db', // Specify the directory for the database
    );
  }
}

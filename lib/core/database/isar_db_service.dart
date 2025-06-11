import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarDBService {
  static late Isar isar;
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [],
      directory: dir.path,
    );
  }
}

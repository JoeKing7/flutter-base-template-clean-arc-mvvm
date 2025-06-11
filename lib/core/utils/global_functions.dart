import 'package:intl/intl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

String formatDate(DateTime date, {String pattern = 'yyyy-MM-dd'}) {
  return DateFormat(pattern).format(date);
}

Future<bool> isConnectedToNetwork() async {
  final result = await Connectivity().checkConnectivity();
  final check = result.firstWhere(
    (element) =>
        element == ConnectivityResult.mobile ||
        element == ConnectivityResult.wifi,
    orElse: () => ConnectivityResult.none,
  );
  return check != ConnectivityResult.none;
}

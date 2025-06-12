import 'package:get/get.dart';

class AppTranslations extends Translations {
  final Map<String, Map<String, String>> _translationKeys;

  AppTranslations(this._translationKeys);
  // @override
  // Map<String, Map<String, String>> get keys => {
  //       'en_US': {'title': 'Flutter Demo Home Page'},
  //       'es_ES': {'title': 'Página de inicio Flutter demo'}
  // };

  @override
  Map<String, Map<String, String>> get keys => _translationKeys;
}

import 'localization/chinese_localization.dart';
import 'localization/english_localization.dart';
import 'localization/myanmar_localization.dart';

enum AppLanguages { en, mm, zh }

class AppLocalization {
  static Map<String, Map<String, String>> translationsKey = {
    AppLanguages.en.name: en,
    AppLanguages.mm.name: mm,
    AppLanguages.zh.name: zh,
  };
}

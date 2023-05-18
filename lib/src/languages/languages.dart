import 'package:get/get.dart';
import 'package:rikedu/src/languages/en_us.dart';
import 'package:rikedu/src/languages/ru_ru.dart';
import 'package:rikedu/src/languages/vi_vn.dart';

class LanguageStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enKeys,
        'vi_VN': viKeys,
        'ru_RU': ruKeys,
      };
}

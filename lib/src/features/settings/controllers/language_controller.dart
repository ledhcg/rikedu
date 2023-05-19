import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/settings/providers/locale_provider.dart';

class LanguageController extends GetxController {
  final localeProvider = Provider.of<LocaleProvider>(Get.context!);

  final RxBool _enStatus = false.obs;
  final RxBool _viStatus = false.obs;
  final RxBool _ruStatus = false.obs;

  bool get enStatus => _enStatus.value;
  bool get viStatus => _viStatus.value;
  bool get ruStatus => _ruStatus.value;

  @override
  void onInit() {
    super.onInit();
    setLanguageActiveStatus();
  }

  void updateLanguage(Locale locale) {
    localeProvider.setLocale(locale);
    setLanguageActiveStatus();
  }

  void setLanguageActiveStatus() {
    _viStatus.value =
        localeProvider.checkLanguageActive(const Locale('vi', 'VN'));
    _enStatus.value =
        localeProvider.checkLanguageActive(const Locale('en', 'US'));
    _ruStatus.value =
        localeProvider.checkLanguageActive(const Locale('ru', 'RU'));
  }
}

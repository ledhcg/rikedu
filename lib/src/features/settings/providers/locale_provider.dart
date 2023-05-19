import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class LocaleProvider extends ChangeNotifier {
  final StorageService _storageService = Get.find();
  late Locale _locale;
  final Locale _localeDefault = const Locale('en', 'US');

  Locale get locale => _locale;
  Locale get localeDefault => _localeDefault;

  Future<void> init() async {
    _locale = await getLocale();
  }

  Future<Locale> getLocale() async {
    final localeString =
        _storageService.readData(StorageConst.SETTING_LOCALE) ?? 'en_US';
    final localeParts = localeString.split('_');
    if (localeParts.length == 2) {
      return Locale(localeParts[0], localeParts[1]);
    }
    return _localeDefault;
  }

  void setLocale(Locale locale) {
    Get.updateLocale(locale);
    _storageService.writeData(StorageConst.SETTING_LOCALE, locale.toString());
    _locale = locale;
    notifyListeners();
  }

  bool checkLanguageActive(Locale locale) {
    final currentLocale = Get.locale;
    if (currentLocale == locale) return true;
    return false;
  }
}

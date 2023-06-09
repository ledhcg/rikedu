import 'package:get/get.dart';
import 'package:rikedu/src/features/settings/controllers/edit_profile_controller.dart';
import 'package:rikedu/src/features/settings/controllers/language_controller.dart';
import 'package:rikedu/src/features/settings/controllers/setting_controller.dart';
import 'package:rikedu/src/features/settings/controllers/theme_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}

import 'package:get/get.dart';
import 'package:rikedu/src/features/settings/controllers/setting_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}

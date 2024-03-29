import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/settings/providers/theme_provider.dart';

class ThemeController extends GetxController {
  final themProvider = Provider.of<ThemeProvider>(Get.context!);
  final RxBool _isOn = false.obs;
  bool get isOn => _isOn.value;

  @override
  void onInit() {
    super.onInit();
    _isOn.value = themProvider.isDarkMode;
  }

  void setTheme(bool isOn) {
    if (isOn) {
      themProvider.setThemeModeType(ThemeModeType.dark);
    } else {
      themProvider.setThemeModeType(ThemeModeType.light);
    }
    _isOn.value = !_isOn.value;
  }
}

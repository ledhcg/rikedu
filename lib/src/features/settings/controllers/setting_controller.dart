import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';

class SettingsController extends GetxController {
  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final Rx<User> _user = User.defaultUser().obs;
  User get user => _user.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isSettingMode = true.obs;
  bool get isSettingMode => _isSettingMode.value;

  @override
  void onInit() {
    super.onInit();
    _user.value = authProvider.user;
    _isLoading.value = false;
  }

  void changeSettingMode() {
    _isSettingMode.value = !isSettingMode;
  }
}

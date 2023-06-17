import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/utils/constants/roles_constants.dart';

class SettingsController extends GetxController {
  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final Rx<User> _user = User.defaultUser().obs;
  User get user => _user.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isStudent = false.obs;
  bool get isStudent => _isStudent.value;

  final RxBool _isSettingMode = true.obs;
  bool get isSettingMode => _isSettingMode.value;

  final RxBool _isShowMap = true.obs;
  bool get isShowMap => _isShowMap.value;

  final RxBool _isShowStudentStatus = true.obs;
  bool get isShowStudentStatus => _isShowStudentStatus.value;

  final RxBool _isShowBattery = true.obs;
  bool get isShowBattery => _isShowBattery.value;

  @override
  void onInit() {
    super.onInit();
    _user.value = authProvider.user;
    if (authProvider.role == RolesConst.STUDENT) {
      _isStudent.value = true;
    }
    _isLoading.value = false;
  }

  void changeSettingMode() {
    _isSettingMode.value = !isSettingMode;
  }

  void changeSwitchShowMap() {
    _isShowMap.value = !isShowMap;
  }

  void changeSwitchShowBattery() {
    _isShowBattery.value = !isShowBattery;
  }

  void changeSwitchShowStudentStatus() {
    _isShowStudentStatus.value = !isShowStudentStatus;
  }
}

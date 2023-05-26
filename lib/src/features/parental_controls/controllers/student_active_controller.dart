import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';

class StudentActiveController extends GetxController {
  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final RxBool _studentIsActive = false.obs;
  bool get studentIsActive => _studentIsActive.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    super.onInit();
    _studentIsActive.value = authProvider.studentIsActive;
    _isLoading.value = false;
  }
}

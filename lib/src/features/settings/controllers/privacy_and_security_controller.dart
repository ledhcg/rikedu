import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyAndSecurityController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiService _apiService = Get.find();

  late WebViewController controllerWV;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final Rx<User> _user = User.defaultUser().obs;
  User get user => _user.value;

  @override
  void onInit() async {
    super.onInit();
    _user.value = authProvider.user;
    controllerWV = WebViewController()
      ..loadRequest(
        Uri.parse('https://rikedu.ru/terms-and-conditions'),
      );
    _isLoading.value = false;
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter text';
    }
    return null;
  }
}

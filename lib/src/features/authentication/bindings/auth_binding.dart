import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

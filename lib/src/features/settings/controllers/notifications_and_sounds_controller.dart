import 'package:get/get.dart';

class NotificationsAndSoundsController extends GetxController {
  final RxBool _isPushNotifications = true.obs;
  bool get isPushNotifications => _isPushNotifications.value;

  final RxBool _isEnableSounds = true.obs;
  bool get isEnableSounds => _isEnableSounds.value;

  void changeSwitchPushNotifications() {
    _isPushNotifications.value = !isPushNotifications;
  }

  void changeSwitchEnableSounds() {
    _isEnableSounds.value = !isEnableSounds;
  }
}

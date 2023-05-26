import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/features/parental_controls/models/notification_dart.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';

class NotificationController extends GetxController {
  final ApiService _apiService = Get.find();
  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final Rx<List<Notifi>> _notifications = Rx<List<Notifi>>(<Notifi>[]);
  List<Notifi> get notifications => _notifications.value;

  final Rx<User> _user = User.defaultUser().obs;
  User get user => _user.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  List<String> tabs = ['School', 'Other'];

  @override
  void onInit() async {
    super.onInit();
    _user.value = authProvider.user;
    await _fetchData();
    _isLoading.value = false;
  }

  Future<void> _fetchData() async {
    try {
      final response = await _apiService
          .get("${ApiConst.NOTIFICATIONS_ENDPOINT}/user/${user.id}");
      if (response.body['success']) {
        List<dynamic> notifications =
            List<dynamic>.from(response.body['data']['notifications']);
        _notifications.value = notifications
            .map((notification) => Notifi.fromJson(notification))
            .toList();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<void> markAsRead(String notificationID) async {
    try {
      final response = await _apiService.put(
          "${ApiConst.NOTIFICATIONS_ENDPOINT}/$notificationID/mark-as-read",
          {});
      if (response.body['success']) {
        await _fetchData();
      } else {}
    } catch (e) {
      rethrow;
    }
  }
}

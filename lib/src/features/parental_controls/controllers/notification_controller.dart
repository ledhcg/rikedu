import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/features/parental_controls/models/notification_model.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';

class NotificationController extends GetxController {
  final ApiService _apiService = Get.find();
  final FirebaseService _firebaseService = Get.find();
  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final Rx<List<Notifi>> _notifications = Rx<List<Notifi>>(<Notifi>[]);
  List<Notifi> get notifications => _notifications.value;

  final Rx<List<Notifi>> _notificationsRealtime = Rx<List<Notifi>>(<Notifi>[]);
  List<Notifi> get notificationsRealtime => _notificationsRealtime.value;

  final Rx<User> _user = User.defaultUser().obs;
  User get user => _user.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingRealtime = true.obs;
  bool get isLoadingRealtime => _isLoadingRealtime.value;

  List<String> tabs = ['School', 'Other'];

  @override
  void onInit() async {
    super.onInit();
    _user.value = authProvider.user;
    await _fetchData();
    _listenNotificationsRealtime();
    _isLoading.value = false;
  }

  Future<void> _fetchData() async {
    try {
      await Future.wait([
        _fetchNotifications(),
        _fetchNotificationsRealtime(),
      ]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _fetchNotifications() async {
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

  Future<void> _fetchNotificationsRealtime() async {
    try {
      await _firebaseService
          .getDataCollection(FirebaseConst.USER_NOTIFICATION)
          .then((querySnapshot) {
        List<dynamic> notificationsSource = [];
        for (final DocumentSnapshot doc in querySnapshot.docs) {
          final data = doc.data() as Map<String, dynamic>;
          if (data['is_read'] == 0) {
            notificationsSource.add({
              'id': doc.id,
              'title': data['title'],
              'message': data['message'],
              'to_user_id': data['to_user_id'],
              'from': data['from'],
              'is_read': data['is_read'],
              'created_at': formatTimestamp(data['created_at']),
              'updated_at': formatTimestamp(data['updated_at']),
            });
          }
        }
        List<dynamic> notificationsRealtime =
            List<dynamic>.from(notificationsSource);
        _notificationsRealtime.value = notificationsRealtime
            .map((notification) => Notifi.fromJson(notification))
            .toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _listenNotificationsRealtime() async {
    _firebaseService
        .listenDataChange(FirebaseConst.USER_NOTIFICATION)
        .then((stream) {
      stream.listen((snapshot) {
        List<dynamic> notificationsSource = [];
        for (var doc in snapshot.docs) {
          final data = doc.data();
          if (data['is_read'] == 0) {
            notificationsSource.add({
              'id': doc.id,
              'title': data['title'],
              'message': data['message'],
              'to_user_id': data['to_user_id'],
              'from': data['from'],
              'is_read': data['is_read'],
              'created_at': formatTimestamp(data['created_at']),
              'updated_at': formatTimestamp(data['updated_at']),
            });
          }
        }
        List<dynamic> notificationsRealtime =
            List<dynamic>.from(notificationsSource);
        _notificationsRealtime.value = notificationsRealtime
            .map((notification) => Notifi.fromJson(notification))
            .toList();
      });
    });
  }

  Future<void> markAsRead(
      String notificationID, int index, String typeMode) async {
    if (typeMode == 'School') {
      try {
        final response = await _apiService.put(
            "${ApiConst.NOTIFICATIONS_ENDPOINT}/$notificationID/mark-as-read",
            {});
        if (response.body['success']) {
          notifications.removeAt(index);
        } else {}
      } catch (e) {
        rethrow;
      }
    }
    if (typeMode == 'Other') {
      final notificationRef = _firebaseService
          .collectionReference(FirebaseConst.USER_NOTIFICATION)
          .doc(notificationID);
      await notificationRef.update({'is_read': 1});
      notificationsRealtime.removeAt(index);
    }
  }

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String formattedString =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime);
    return formattedString;
  }
}

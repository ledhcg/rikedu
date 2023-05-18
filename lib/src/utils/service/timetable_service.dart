import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimetableService extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;

  Future<void> getTimetableData(String groupId) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('token') ?? '';

      final response = await Dio().get(
        "$timetableUrl/$groupId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (kDebugMode) {
        print('Timetable: ${response.data}');
      }
      _loading = false;
      notifyListeners();
    } on DioError catch (e) {
      if (e.response != null) {
        if (kDebugMode) {
          print('Dio error!');
          print('STATUS: ${e.response?.statusCode}');
          print('DATA: ${e.response?.data}');
          print('HEADERS: ${e.response?.headers}');
        }
      } else {
        if (kDebugMode) {
          print('Error sending request!');
          print(e.message);
        }
      }
      rethrow;
    }
  }
}

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/constants/keys_storage_constants.dart';

class AuthProvider extends GetConnect {
  final GetStorage _localStorage = GetStorage();

  Future<Response> login(String emailUsername, String password) async {
    try {
      final response = await post(ApiConst.LOGIN_ENDPOINT, {
        'email_username': emailUsername,
        'password': password,
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> logout() async {
  //   try {
  //     await _apiService.post(ApiConst.LOGOUT_ENDPOINT, {});
  //     await _localStorage.remove(KeysStorageConst.USER_DATA);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}

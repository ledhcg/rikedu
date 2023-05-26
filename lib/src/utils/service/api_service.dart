import 'package:get/get.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';

class ApiService extends GetConnect implements GetxService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  @override
  void onInit() {
    httpClient.baseUrl = ApiConst.BASE_URL;
    super.onInit();
  }
}

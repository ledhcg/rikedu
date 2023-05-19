// import 'package:dio/dio.dart';
// import 'package:rikedu/src/utils/constants/api_constants.dart';

// class ApiService {
//   final Dio _dio = Dio(BaseOptions(baseUrl: ApiConst.BASE_URL));

//   Future<Response> get(String path) async {
//     try {
//       final response = await _dio.get(path);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Response> post(String path, dynamic data) async {
//     try {
//       final response = await _dio.post(path, data: data);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Response> put(String path, dynamic data) async {
//     try {
//       final response = await _dio.put(path, data: data);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   Future<Response> delete(String path) async {
//     try {
//       final response = await _dio.delete(path);
//       return response;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

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

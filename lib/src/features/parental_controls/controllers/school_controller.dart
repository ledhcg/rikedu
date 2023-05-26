import 'dart:convert';

import 'package:get/get.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:http/http.dart' as http;

class SchoolController extends GetxController {
  final ApiService _apiService = Get.find();

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxString _quote = ''.obs;
  String get quote => _quote.value;
  set quote(String value) => _quote.value = value;

  final RxString _author = ''.obs;
  String get author => _author.value;
  set author(String value) => _author.value = value;

  final RxString _imageURL = ''.obs;
  String get imageURL => _imageURL.value;
  set imageURL(String value) => _imageURL.value = value;

  @override
  void onInit() async {
    super.onInit();
    await getQuote();
    await getImage();
    _isLoading.value = false;
  }

  Future<void> getQuote() async {
    try {
      const url = 'https://api.api-ninjas.com/v1/quotes?category=success';
      final headers = {'X-Api-Key': 'R/Kcg3xCMPKwDgan/+YRsg==kpje90vhvM4MYa5l'};

      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        author = responseData[0]['author'];
        quote = responseData[0]['quote'];
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getImage() async {
    try {
      const url =
          "https://api.unsplash.com/photos/?client_id=auKDa2lTmbPzeNGrrezDZgX3HSiZilStZTfzJ8ect_Y";

      final response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        imageURL = responseData[0]['urls']['regular'];
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}

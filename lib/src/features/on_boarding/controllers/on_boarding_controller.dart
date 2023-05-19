import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  final RxBool _isLastPage = false.obs;
  bool get isLastPage => _isLastPage.value;
  void updateIsLastPage(bool isLastPage) {
    _isLastPage.value = isLastPage;
  }
}

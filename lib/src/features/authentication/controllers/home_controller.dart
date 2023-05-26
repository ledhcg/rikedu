import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt _selectedIndex = 0.obs;
  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;
}

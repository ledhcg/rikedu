import 'package:app_usage/app_usage.dart';
import 'package:get/get.dart';

class AppUsageController extends GetxController {
  List<AppUsageInfo> _appUsageList = [];
  List<AppUsageInfo> get appUsageList => _appUsageList;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    super.onInit();
    getListAppUsage();
    _isLoading.value = false;
  }

  Future<void> getListAppUsage() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(days: 1));

    List<AppUsageInfo> appUsageList =
        await AppUsage().getAppUsage(startDate, endDate);

    appUsageList.sort(
        (a, b) => b.usage.inMilliseconds.compareTo(a.usage.inMilliseconds));
    _appUsageList = appUsageList;
  }
}

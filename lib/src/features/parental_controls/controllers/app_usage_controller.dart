import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/parental_controls/providers/app_usage_provider.dart';

class AppUsageController extends GetxController {
  final appUsageProvider = Provider.of<AppUsageProvider>(Get.context!);
  Stream<DocumentSnapshot<Object?>>? _dataStream;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxList _listApp = [].obs;
  List get listApp => _listApp.value;

  @override
  void onInit() async {
    super.onInit();
    listenDataAppUsage();
    _isLoading.value = false;
  }

  Future<void> listenDataAppUsage() async {
    _dataStream = await appUsageProvider.streamAppUsage();
    _dataStream!.listen((snapshot) async {
      // Handle the received snapshot
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        _listApp.value = data['appUsage'];
        print("APP USAGE: ${data['appUsage'][0]["iconApp"]}");
      } else {
        print("The document doesn't exist");
      }
    }, onError: (error) {
      print(error);
    });
  }
}

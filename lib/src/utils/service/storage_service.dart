// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class StorageService extends GetxService {
//   Future<StorageService> init() async {
//     await GetStorage.init();
//     return this;
//   }

//   void write(String key, dynamic value) {
//     GetStorage().write(key, value);
//   }

//   dynamic read(String key) {
//     return GetStorage().read(key);
//   }

//   void remove(String key) {
//     GetStorage().read(key);
//   }
// }
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static StorageService get to => Get.find();

  Future<StorageService> init() async {
    await GetStorage.init();
    return this;
  }

  Future<void> writeData(String key, dynamic value) async {
    final box = GetStorage();
    await box.write(key, value);
  }

  dynamic readData(String key) {
    final box = GetStorage();
    return box.read(key);
  }

  bool hasData(String key) {
    final box = GetStorage();
    return box.hasData(key);
  }

  Future<void> removeData(String key) async {
    final box = GetStorage();
    await box.remove(key);
  }

  Future<void> clearData() async {
    final box = GetStorage();
    await box.erase();
  }
}

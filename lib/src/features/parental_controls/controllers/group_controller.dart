import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class GroupController extends GetxController {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();

  final Rx<List<User>> _students = Rx<List<User>>(<User>[]);
  List<User> get students => _students.value;
  final Rx<List<User>> _teachers = Rx<List<User>>(<User>[]);
  List<User> get teachers => _teachers.value;

  final RxString _groupID = ''.obs;
  String get groupID => _groupID.value;

  final RxString _groupName = ''.obs;
  String get groupName => _groupName.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  List<String> tabs = ['Teachers', 'Students'];
  @override
  void onInit() async {
    super.onInit();
    await _getGroupID();
    await _fetchData();
    _isLoading.value = false;
  }

  Future<void> _fetchData() async {
    try {
      final response =
          await _apiService.get("${ApiConst.GROUPS_ENDPOINT}/$groupID");
      if (response.body['success']) {
        List<dynamic> teachers =
            List<dynamic>.from(response.body['data']['teachers']);
        _teachers.value =
            teachers.map((teacher) => User.fromJson(teacher)).toList();

        List<dynamic> students =
            List<dynamic>.from(response.body['data']['students']);
        _students.value =
            students.map((student) => User.fromJson(student)).toList();

        _groupName.value = response.body['data']['group_name'];
        print(groupName);
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getGroupID() async {
    if (_storageService.hasData(StorageConst.GROUP_ID)) {
      _groupID.value = await _storageService.readData(StorageConst.GROUP_ID);
    }
  }
}

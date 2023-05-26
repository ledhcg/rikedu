import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/features/parental_controls/models/exam_model.dart';
import 'package:rikedu/src/features/parental_controls/models/result_model.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/constants/storage_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/service/storage_service.dart';

class ResultsController extends GetxController {
  final ApiService _apiService = Get.find();
  final StorageService _storageService = Get.find();
  final authProvider = Provider.of<AuthProvider>(Get.context!);

  final Rx<List<Result>> _results = Rx<List<Result>>(<Result>[]);
  List<Result> get results => _results.value;

  final Rx<List<Exam>> _exams = Rx<List<Exam>>(<Exam>[]);
  List<Exam> get exams => _exams.value;

  final RxString _studentID = ''.obs;
  String get studentID => _studentID.value;

  final Rx<User> _student = User.defaultUser().obs;
  User get student => _student.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  List<String> tabs = ['Performance Table', 'Exams'];

  @override
  void onInit() async {
    super.onInit();
    _student.value = authProvider.student;
    await _getStudentID();
    await _fetchDataResults();
    await _fetchDataExams();
    _isLoading.value = false;
  }

  Future<void> _fetchDataResults() async {
    try {
      final response =
          await _apiService.get("${ApiConst.RESULTS_ENDPOINT}/$studentID");
      if (response.body['success']) {
        List<dynamic> results =
            List<dynamic>.from(response.body['data']['results']);
        _results.value =
            results.map((result) => Result.fromJson(result)).toList();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _fetchDataExams() async {
    try {
      final response =
          await _apiService.get("${ApiConst.EXAMS_ENDPOINT}/$studentID");
      if (response.body['success']) {
        List<dynamic> exams =
            List<dynamic>.from(response.body['data']['exams']);
        _exams.value = exams.map((exam) => Exam.fromJson(exam)).toList();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _getStudentID() async {
    if (_storageService.hasData(StorageConst.STUDENT_ID)) {
      _studentID.value =
          await _storageService.readData(StorageConst.STUDENT_ID);
    }
  }
}

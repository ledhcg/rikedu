import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/features/parental_controls/models/exercise_model.dart';
import 'package:rikedu/src/utils/constants/api_constants.dart';
import 'package:rikedu/src/utils/service/api_service.dart';
import 'package:rikedu/src/utils/widgets/snackbar_widget.dart';

class ExerciseController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ApiService _apiService = Get.find();
  final authProvider = Provider.of<AuthProvider>(Get.context!);

  late AnimationController loadingController;
  final Rx<File?> _file = Rx<File?>(null);
  File? get file => _file.value;
  late final Rx<PlatformFile?> _platformFile = Rx<PlatformFile?>(null);
  PlatformFile? get platformFile => _platformFile.value;

  final Rx<List<Exercise>> _exercises = Rx<List<Exercise>>(<Exercise>[]);
  List<Exercise> get exercises => _exercises.value;

  final Rx<Exercise> _exerciseSubmit = Rx<Exercise>(Exercise.defaultExercise());
  Exercise get exerciseSubmit => _exerciseSubmit.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxBool _isLoadingSubmit = false.obs;
  bool get isLoadingSubmit => _isLoadingSubmit.value;

  final RxBool _hasDataSubmit = false.obs;
  bool get hasDataSubmit => _hasDataSubmit.value;

  final RxDouble _loadingValue = 0.0.obs;
  double get loadingValue => _loadingValue.value;

  final Rx<Icon?> _icon = Rx<Icon?>(null);
  Icon? get icon => _icon.value;

  final Rx<User> _student = User.defaultUser().obs;
  User get student => _student.value;

  final Rx<TextEditingController> _markController =
      Rx<TextEditingController>(TextEditingController());
  TextEditingController get markController => _markController.value;

  final Rx<TextEditingController> _reviewController =
      Rx<TextEditingController>(TextEditingController());

  TextEditingController get reviewController => _reviewController.value;

  @override
  void onInit() async {
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        update();
        _loadingValue.value = loadingController.value;
        print("Process: $loadingValue");
      });
    _student.value = authProvider.student;
    await _fetchData();
    super.onInit();
    _isLoading.value = false;
  }

  void getDataExerciseSubmit() {
    markController.text = exerciseSubmit.mark.toString();
    reviewController.text = exerciseSubmit.review;
    _hasDataSubmit.value = true;
  }

  Future<void> _fetchData() async {
    // print("Exercises: $exercises");
    print("Student ID: ${student.id}");
    try {
      final response = await _apiService
          .get("${ApiConst.EXERCISES_ENDPOINT}/user/${student.id}");
      if (response.body['success']) {
        List<dynamic> exercises =
            List<dynamic>.from(response.body['data']['exercises']);
        print("Exercises: $exercises");
        print("Student ID: ${student.id}");
        _exercises.value =
            exercises.map((exercise) => Exercise.fromJson(exercise)).toList();
      } else {}
    } catch (e) {
      rethrow;
    }
  }

  void selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
        onFileLoading: (value) {},
        withReadStream: true);

    if (file != null) {
      _file.value = File(file.files.single.path!);
      _platformFile.value = file.files.first;
      _icon.value = setExtensionIcon(platformFile!);
    }
    loadingController.forward();
  }

  void onSubmit(String exerciseID, int exerciseIndex) async {
    _isLoadingSubmit.value = true;
    print("ExerciseID: $exerciseID");
    try {
      String? filePath = platformFile!.path;
      File file = File(filePath!);
      String fileName = file.path.split('/').last;

      final formData = FormData({
        'file': MultipartFile(
          await file.readAsBytes(),
          filename: fileName,
        ),
        '_method': 'PUT',
      });
      final response = await _apiService.post(
          "${ApiConst.EXERCISES_ENDPOINT}/$exerciseID/submit", formData);
      print("Response message: ${response.body['message']}");
      if (response.body['success']) {
        dynamic exercise = response.body['data'];
        _exerciseSubmit.value = Exercise.fromJson(exercise);
        _exercises.value[exerciseIndex] = Exercise.fromJson(exercise);
        getDataExerciseSubmit();
        resetDataDefault(false);
        SnackbarWidget.showSnackbarSuccess(
            response.body['message'].toString().tr);
      } else {}
    } catch (e) {
      rethrow;
    }
    _isLoadingSubmit.value = false;
  }

  void resetDataDefault(bool allData) {
    _platformFile.value = null;
    _file.value = null;
    _loadingValue.value = 0.0;
    if (allData) {
      _exerciseSubmit.value = Exercise.defaultExercise();
      markController.text = '';
      reviewController.text = '';
      _hasDataSubmit.value = false;
      loadingController.reset();
    }
  }

  void openFile(Exercise exercise) async {
    Get.toNamed(Routes.EXERCISE_DETAIL_VIEW_FILE, arguments: exercise);
  }

  Icon setExtensionIcon(PlatformFile platformFile) {
    if (platformFile.extension.toString() == 'pdf') {
      return const Icon(
        FluentIcons.document_pdf_32_filled,
        color: Colors.blue,
        size: 40,
      );
    }
    return const Icon(
      FluentIcons.document_text_24_filled,
      color: Colors.blue,
      size: 40,
    );
  }

  @override
  void onClose() {
    loadingController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    loadingController.dispose();
    super.dispose();
  }
}

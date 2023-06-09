import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/src/features/authentication/providers/auth_provider.dart';
import 'package:rikedu/src/utils/constants/firebase_constants.dart';
import 'package:rikedu/src/utils/service/firebase_service.dart';

class StudentActiveController extends GetxController {
  final authProvider = Provider.of<AuthProvider>(Get.context!);
  final FirebaseService firebaseService = Get.find();

  Stream<DocumentSnapshot<Object?>>? _dataStream;

  final RxBool _studentIsActive = false.obs;
  bool get studentIsActive => _studentIsActive.value;

  final RxString _studentID = ''.obs;
  String get studentID => _studentID.value;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() async {
    super.onInit();
    _studentID.value = authProvider.student.id;
    _listenStudentStatus();
    _isLoading.value = false;
  }

  Future<void> _listenStudentStatus() async {
    _dataStream =
        await firebaseService.streamData(FirebaseConst.USER, studentID);
    _dataStream!.listen((snapshot) async {
      // Handle the received snapshot
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        _studentIsActive.value = data['isActive'];
        print("ACTIVE: ${data['isActive']}");
      } else {
        print("The document doesn't exist");
      }
    }, onError: (error) {
      print(error);
    });
  }
}

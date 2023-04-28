import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rike/main.dart';
import 'package:rike/src/features/settings/views/settings.dart';
import 'package:rike/src/repository/authentication/exceptions/sign_up_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> rikeUser;

  @override
  void onReady() {
    rikeUser = Rx<User?>(_auth.currentUser);
    rikeUser.bindStream(_auth.userChanges());
    ever(rikeUser, _setInitialScreen);
  }

  _setInitialScreen(User? rikeUser) {
    rikeUser == null
        ? Get.offAll(() => const HomePage(title: 'Test'))
        : Get.offAll(() => const HomePage(title: 'Rikedu'));
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      rikeUser.value != null
          ? Get.offAll(() => const HomePage(title: 'Rikedu'))
          : Get.offAll(() => const SettingsScreen());
    } on FirebaseAuthException catch (e) {
      final ex = SignUpFailure.code(e.code);
      if (kDebugMode) {
        print('SIGN UP EX: ${ex.message}');
      }
      throw ex;
    } catch (_) {
      const ex = SignUpFailure();
      if (kDebugMode) {
        print('SIGN UP EX: ${ex.message}');
      }
      throw ex;
    }
  }

  // Future<void> signInWithEmailAndPassword(String email, String password) async {
  //   try {
  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //   } catch(_){}
  // }

  Future<void> signOut() async => await _auth.signOut();
}

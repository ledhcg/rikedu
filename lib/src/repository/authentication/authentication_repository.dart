import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rikedu/main.dart';
import 'package:rikedu/src/features/on_boarding/screens/on_boarding_page.dart';
import 'package:rikedu/src/repository/authentication/exceptions/register_failure.dart';

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
        ? Get.offAll(() => OnBoardingPage())
        : Get.offAll(() => const HomePage());
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      rikeUser.value != null
          ? Get.offAll(() => const HomePage())
          : Get.offAll(() => OnBoardingPage());
    } on FirebaseAuthException catch (e) {
      final ex = RegisterFailure.code(e.code);
      if (kDebugMode) {
        print('SIGN UP EX: ${ex.message}');
      }
      throw ex;
    } catch (_) {
      const ex = RegisterFailure();
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

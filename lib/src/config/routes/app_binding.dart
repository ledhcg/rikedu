import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/controllers/home_controller.dart';
import 'package:rikedu/src/features/news/controllers/post_controller.dart';
import 'package:rikedu/src/features/on_boarding/controllers/on_boarding_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/baterry_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/group_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/map_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/parental_controls_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/school_controller.dart';
import 'package:rikedu/src/features/parental_controls/controllers/student_active_controller.dart';
import 'package:rikedu/src/features/settings/controllers/about_controller.dart';
import 'package:rikedu/src/features/settings/controllers/edit_profile_controller.dart';
import 'package:rikedu/src/features/settings/controllers/language_controller.dart';
import 'package:rikedu/src/features/settings/controllers/logout_controller.dart';
import 'package:rikedu/src/features/settings/controllers/notifications_and_sounds_controller.dart';
import 'package:rikedu/src/features/settings/controllers/privacy_and_security_controller.dart';
import 'package:rikedu/src/features/settings/controllers/setting_controller.dart';
import 'package:rikedu/src/features/settings/controllers/theme_controller.dart';
import 'package:rikedu/src/features/timetable/controllers/timetable_controller.dart';
import 'package:rikedu/src/features/authentication/controllers/auth_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnBoardingController>(() => OnBoardingController());
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<LanguageController>(() => LanguageController());
    Get.lazyPut<LogoutController>(() => LogoutController());
    Get.lazyPut<TimetableController>(() => TimetableController());
    Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<BatteryController>(() => BatteryController());
    Get.lazyPut<PostController>(() => PostController());
    Get.lazyPut<ParentalControlsController>(() => ParentalControlsController());
    Get.lazyPut<StudentActiveController>(() => StudentActiveController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<GroupController>(() => GroupController());
    Get.lazyPut<AboutController>(() => AboutController());
    Get.lazyPut<SchoolController>(() => SchoolController());
    Get.lazyPut<EditProfileController>(() => EditProfileController());
    Get.lazyPut<PrivacyAndSecurityController>(
        () => PrivacyAndSecurityController());
    Get.lazyPut<NotificationsAndSoundsController>(
        () => NotificationsAndSoundsController());
  }
}

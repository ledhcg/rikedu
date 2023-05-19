import 'package:get/get.dart';
import 'package:rikedu/main.dart';
import 'package:rikedu/src/features/authentication/bindings/auth_binding.dart';
import 'package:rikedu/src/features/authentication/views/login_page.dart';
import 'package:rikedu/src/features/parental_controls/views/parental_controls_page.dart';
import 'package:rikedu/src/features/settings/bindings/settings_binding.dart';
import 'package:rikedu/src/features/settings/views/settings_page.dart';
import 'package:rikedu/src/features/timetable/bindings/timetable_binding.dart';
import 'package:rikedu/src/features/timetable/views/timetable_page.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TIMETABLE,
      page: () => const TimetablePage(),
      binding: TimetableBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
  ];
}

class NavigationPages extends GetxController {
  final List<GetPage> pages = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.TIMETABLE,
      page: () => const TimetablePage(),
      binding: TimetableBinding(),
    ),
    GetPage(
      name: Routes.PARENTAL_CONTROLS,
      page: () => const ParentalControlsPage(),
      // binding: TimetableBinding(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
  ];
}

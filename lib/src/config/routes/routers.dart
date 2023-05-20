import 'package:get/get.dart';
import 'package:rikedu/main.dart';
import 'package:rikedu/src/features/authentication/bindings/auth_binding.dart';
import 'package:rikedu/src/features/authentication/views/login_page.dart';
import 'package:rikedu/src/features/on_boarding/screens/on_boarding_page.dart';
import 'package:rikedu/src/features/parental_controls/views/parental_controls_page.dart';
import 'package:rikedu/src/features/settings/views/settings_page.dart';
import 'package:rikedu/src/features/timetable/views/timetable_page.dart';

class RikeRoutes {
  static String home = "/";
  static String login = "/login";
  static String onBoarding = "/on-boarding";
  static String timetable = "/timetable";
  static String settings = "/settings";
  static String parentalControls = "/parental-controls";

  static String getHomeRoute() => home;
  static String getLoginRoute() => login;
  static String getOnBoardingRoute() => onBoarding;
  static String getTimetableRoute() => timetable;
  static String getSettingsRoute() => settings;
  static String getParentalControlsRoute() => parentalControls;

  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(
      name: login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(name: onBoarding, page: () => OnBoardingPage()),
    GetPage(name: timetable, page: () => TimetablePage()),
    GetPage(name: settings, page: () => const SettingsPage()),
    GetPage(name: parentalControls, page: () => const ParentalControlsPage()),
  ];
}

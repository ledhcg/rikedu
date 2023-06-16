import 'package:get/get.dart';
import 'package:rikedu/main.dart';
import 'package:rikedu/src/config/routes/app_binding.dart';
import 'package:rikedu/src/features/authentication/views/login_page.dart';
import 'package:rikedu/src/features/news/views/news_detail_page.dart';
import 'package:rikedu/src/features/news/views/news_page.dart';
import 'package:rikedu/src/features/parental_controls/bindings/parental_controls_binding.dart';
import 'package:rikedu/src/features/parental_controls/views/app_usage_page.dart';
import 'package:rikedu/src/features/parental_controls/views/exercise_detail_page.dart';
import 'package:rikedu/src/features/parental_controls/views/exercise_detail_view_file.dart';
import 'package:rikedu/src/features/parental_controls/views/exercise_page.dart';
import 'package:rikedu/src/features/parental_controls/views/group_page.dart';
import 'package:rikedu/src/features/parental_controls/views/notification_page.dart';
import 'package:rikedu/src/features/parental_controls/views/results_page.dart';
import 'package:rikedu/src/features/settings/views/settings_page.dart';
import 'package:rikedu/src/features/timetable/views/timetable_page.dart';

part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginPage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomePage(),
      binding: AppBinding(),
    ),
    GetPage(
      name: Routes.TIMETABLE,
      page: () => TimetablePage(),
    ),
    GetPage(
      name: Routes.SETTINGS,
      page: () => const SettingsPage(),
    ),
    GetPage(
      name: Routes.NEWS,
      page: () => const NewsPage(),
    ),
    GetPage(
      name: Routes.NEWS_DETAIL,
      page: () => const NewsDetailPage(),
    ),
    GetPage(
      name: Routes.GROUP,
      page: () => const GroupPage(),
      binding: ParentalControlsBinding(),
    ),
    GetPage(
      name: Routes.APP_USAGE,
      page: () => const AppUsagePage(),
      binding: ParentalControlsBinding(),
    ),
    GetPage(
      name: Routes.RESULTS,
      page: () => const ResultsPage(),
      binding: ParentalControlsBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => const NotificationPage(),
      binding: ParentalControlsBinding(),
    ),
    GetPage(
      name: Routes.EXERCISE,
      page: () => const ExercisePage(),
      binding: ParentalControlsBinding(),
    ),
    GetPage(
      name: Routes.EXERCISE_DETAIL,
      page: () => const ExerciseDetailPage(),
      binding: ParentalControlsBinding(),
    ),
    GetPage(
      name: Routes.EXERCISE_DETAIL_VIEW_FILE,
      page: () => const ExerciseDetailViewFilePage(),
      binding: ParentalControlsBinding(),
    ),
  ];
}

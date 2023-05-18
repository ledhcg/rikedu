import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/firebase_options.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/config/routes/routers.dart';
import 'package:rikedu/src/config/themes/themes.dart';
import 'package:rikedu/src/features/parental_controls/views/app_usage.dart';
import 'package:rikedu/src/features/parental_controls/views/app_usage_screen.dart';
import 'package:rikedu/src/features/performance/screens/performance.dart';
import 'package:rikedu/src/features/settings/bindings/settings_binding.dart';
import 'package:rikedu/src/features/settings/controllers/setting_controller.dart';
import 'package:rikedu/src/utils/constants/text_strings.dart';
import 'package:rikedu/src/features/chat/views/message.dart';
import 'package:rikedu/src/features/parental_controls/views/location.dart';
import 'package:rikedu/src/features/parental_controls/views/parental_controls_page.dart';
import 'package:rikedu/src/features/settings/views/settings_page.dart';
import 'package:rikedu/src/features/timetable/views/timetable_page.dart';
import 'package:rikedu/src/languages/languages.dart';
// import 'package:rikedu/src/providers/auth_provider.dart';
import 'package:rikedu/src/providers/theme_mode.dart';
import 'package:rikedu/src/repository/authentication/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'src/features/authentication/bindings/auth_binding.dart';
import 'src/utils/service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  bool isDarkMode = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
          .platformBrightness ==
      Brightness.dark;

  Brightness statusBarIconBrightness =
      isDarkMode ? Brightness.light : Brightness.dark;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarIconBrightness: statusBarIconBrightness,
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent,
    ),
  );

  final themeModeManager = ThemeModeManager();
  final authService = AuthService();
  await themeModeManager.init();
  await GetStorage.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  // Intl.defaultLocale = 'ru_RU';
  initializeDateFormatting('ru_RU');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => themeModeManager),
    ChangeNotifierProvider(create: (_) => authService),
  ], child: const MainApp())
      // ChangeNotifierProvider(
      //   create: (_) => themeModeManager,
      //   child: const MainApp(),
      // ),
      );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeModeManager = Provider.of<ThemeModeManager>(context);
    return GetMaterialApp(
      title: 'Rikedu',
      theme: RikeTheme.lightTheme,
      darkTheme: RikeTheme.darkTheme,
      themeMode: themeModeManager.themeModeType == ThemeModeType.dark
          ? ThemeMode.dark
          : ThemeMode.light,
      home: const HomePage(title: 'Rikedu'),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.HOME,
      // getPages: RikeRoutes.routes,
      getPages: AppPages.pages,
      initialBinding: AppBinding(),
      translations: LanguageStrings(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _navigationPages = [
    const MainPage(),
    const TimetablePage(),
    const ParentalControlsPage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _navigationPages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: GNav(
                rippleColor: Theme.of(context).colorScheme.surface,
                hoverColor: Theme.of(context).colorScheme.scrim,
                gap: 8,
                activeColor: Theme.of(context).colorScheme.onPrimary,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Theme.of(context).colorScheme.primary,
                color: Theme.of(context).colorScheme.onBackground,
                tabs: const [
                  GButton(
                    icon: FluentIcons.home_24_regular,
                    text: 'Home',
                  ),
                  GButton(
                    icon: FluentIcons.calendar_ltr_24_regular,
                    text: timetable,
                  ),
                  GButton(
                    icon: FluentIcons.communication_person_24_regular,
                    text: 'Control',
                  ),
                  GButton(
                    icon: FluentIcons.settings_24_regular,
                    text: settings,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FilledButton(
            // onPressed: () => {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => const LoginPage()))
            //   // Get.to(
            //   //   () => const LoginPage(),
            //   //   binding: AuthBinding(),
            //   // )
            // },
            onPressed: () => {Get.toNamed(Routes.LOGIN)},
            child: const Text(
              'Login',
            ),
          ),
          FilledButton(
            onPressed: () => {Get.toNamed(Routes.SETTINGS)},
            child: const Text(
              'Settings',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MessageScreen()))
            },
            child: const Text(
              'Message',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TimetablePage()))
            },
            child: const Text(
              'Timetable',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RealtimeLocation()))
            },
            child: const Text(
              'Map',
            ),
          ),
          FilledButton(
            onPressed: () => {
              // Get.to(() => const TestRealtimeLocation())
              Get.toNamed(RikeRoutes.getParentalControlsRoute())
            },
            child: const Text(
              'Test Map',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PhoneUsage()))
            },
            child: const Text(
              'Usage',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AppUsageStats()))
            },
            child: const Text(
              'Usage',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PerformancePage()))
            },
            child: const Text(
              'Performance',
            ),
          ),
        ],
      ),
    );
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}

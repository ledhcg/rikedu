import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/firebase_options.dart';
import 'package:rikedu/src/constants/text_strings.dart';
import 'package:rikedu/src/features/authentication/views/login/login_screen.dart';
import 'package:rikedu/src/features/authentication/views/login/register_screen.dart';
import 'package:rikedu/src/features/chat/views/message.dart';
import 'package:rikedu/src/features/parental_controls/views/app_usage.dart';
import 'package:rikedu/src/features/parental_controls/views/location.dart';
import 'package:rikedu/src/features/parental_controls/views/test.dart';
import 'package:rikedu/src/features/settings/views/settings_screen.dart';
import 'package:rikedu/src/features/timetable/views/timetable.dart';
import 'package:rikedu/src/providers/theme_mode.dart';
import 'package:rikedu/src/repository/authentication/authentication_repository.dart';
import 'package:rikedu/src/utils/themes/rike_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

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
  await themeModeManager.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  // Intl.defaultLocale = 'ru_RU';
  initializeDateFormatting('ru_RU');

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeModeManager,
      child: const MainApp(),
    ),
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

  final List<Widget> _pages = [
    const MainPage(),
    TimetableScreen(),
    const TestRealtimeLocation(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: _pages[_selectedIndex],
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
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()))
            },
            child: const Text(
              'Login',
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TimetableScreen()))
            },
            child: const Text(
              'Timetable',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RealtimeLocation()))
            },
            child: const Text(
              'Map',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()))
            },
            child: const Text(
              'Signup',
            ),
          ),
          FilledButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TestRealtimeLocation()))
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
                      builder: (context) => const SettingsScreen()))
            },
            child: const Text(
              'Settings',
            ),
          ),
        ],
      ),
    );
  }
}

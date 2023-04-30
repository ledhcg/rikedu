import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rikedu/firebase_options.dart';
import 'package:rikedu/src/features/authentication/views/login/login_screen.dart';
import 'package:rikedu/src/features/authentication/views/login/register_screen.dart';
import 'package:rikedu/src/features/chat/views/message.dart';
import 'package:rikedu/src/features/parental_controls/views/app_usage.dart';
import 'package:rikedu/src/features/parental_controls/views/location.dart';
import 'package:rikedu/src/features/parental_controls/views/test.dart';
import 'package:rikedu/src/features/settings/views/settings_screen.dart';
import 'package:rikedu/src/features/timetable/views/timetable.dart';
import 'package:rikedu/src/repository/authentication/authentication_repository.dart';
import 'package:rikedu/src/utils/themes/rike_theme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  // Intl.defaultLocale = 'ru_RU';
  initializeDateFormatting('ru_RU');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Rikedu',
      theme: RikeTheme.lightTheme,
      darkTheme: RikeTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(title: 'Rikedu'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FilledButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()))
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
      ),
    );
  }
}

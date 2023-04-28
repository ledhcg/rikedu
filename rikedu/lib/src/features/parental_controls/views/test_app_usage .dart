import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() => runApp(const PhoneUsage());

class PhoneUsage extends StatefulWidget {
  const PhoneUsage({super.key});

  @override
  _PhoneUsageState createState() => _PhoneUsageState();
}

class _PhoneUsageState extends State<PhoneUsage> {
  late Future<List<Application>> _appsFuture;

  @override
  void initState() {
    super.initState();
    _appsFuture = fetchAllApps();
  }

  Future<void> trackAppUsage(String packageName, String appName) async {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    await analytics.logEvent(
      name: 'app_usage',
      parameters: <String, dynamic>{
        'package_name': packageName,
        'app_name': appName,
      },
    );
  }

  Future<List<Application>> fetchAllApps() async {
    return await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Installed Apps')),
      body: FutureBuilder<List<Application>>(
        future: _appsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Application app = snapshot.data![index];
                  return ListTile(
                    title: Text(app.appName),
                    subtitle: Text(app.packageName),
                    leading: app is ApplicationWithIcon
                        ? Image.memory(app.icon)
                        : null,
                    onTap: () {
                      // Track app usage
                      trackAppUsage(app.packageName, app.appName);
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text('No apps found.'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

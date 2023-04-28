// import 'package:device_apps/device_apps.dart';
// import 'package:flutter/material.dart';
// import 'package:app_usage/app_usage.dart';
// import 'package:rike/src/features/parental_controls/views/icon_application.dart';

// void main() => runApp(const PhoneUsage());

// class PhoneUsage extends StatefulWidget {
//   const PhoneUsage({super.key});

//   @override
//   _PhoneUsageState createState() => _PhoneUsageState();
// }

// class _PhoneUsageState extends State<PhoneUsage> {
//   List<AppUsageInfo> _infos = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   void getUsageStats() async {
//     try {
//       DateTime endDate = DateTime.now();
//       DateTime startDate = endDate.subtract(const Duration(hours: 1));
//       List<AppUsageInfo> infoList =
//           await AppUsage().getAppUsage(startDate, endDate);
//       setState(() => _infos = infoList);

//       for (var info in infoList) {
//         print(info.toString());
//       }
//     } on AppUsageException catch (exception) {
//       print(exception);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('App Usage Example'),
//           backgroundColor: Colors.green,
//         ),
//         body: ListView.builder(
//             itemCount: _infos.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                   title: Column(
//                     children: [
//                       Text(_infos[index].appName),
//                       Text(_infos[index].packageName),
//                       IconApplication(packageName: _infos[index].packageName),
//                     ],
//                   ),
//                   trailing: Text(_infos[index].usage.toString()));
//             }),
//         floatingActionButton: FloatingActionButton(
//             onPressed: getUsageStats, child: const Icon(Icons.file_download)),
//       ),
//     );
//   }
// }

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

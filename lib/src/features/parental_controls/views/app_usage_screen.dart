import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:app_usage/app_usage.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';

class AppUsageStats extends StatefulWidget {
  const AppUsageStats({super.key});

  @override
  _AppUsageStatsState createState() => _AppUsageStatsState();
}

class _AppUsageStatsState extends State<AppUsageStats> {
  List<AppUsageInfo> _appUsageList = [];
  late Color _cardColor;

  @override
  void initState() {
    super.initState();
    getAppUsageStats();
  }

  Future<void> getAppUsageStats() async {
    DateTime endDate = DateTime.now();
    DateTime startDate = endDate.subtract(const Duration(days: 1));

    List<AppUsageInfo> appUsageList =
        await AppUsage().getAppUsage(startDate, endDate);

    appUsageList.sort(
        (a, b) => b.usage.inMilliseconds.compareTo(a.usage.inMilliseconds));

    setState(() {
      _appUsageList = appUsageList;
    });
  }

  @override
  Widget build(BuildContext context) {
    _cardColor = Theme.of(context).colorScheme.primaryContainer;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'appUsage',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        leading: Transform.translate(
          offset: const Offset(SizesConst.P1, 0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(FluentIcons.chevron_left_48_filled),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _cardColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: ListView.builder(
          itemCount: _appUsageList.length,
          itemBuilder: (context, index) {
            final appUsageInfo = _appUsageList[index];
            return FutureBuilder<Application?>(
              future: DeviceApps.getApp(appUsageInfo.packageName, true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.systemApp) {
                  return const SizedBox.shrink();
                }

                final app = snapshot.data!;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: ListTile(
                        leading: app is ApplicationWithIcon
                            ? CircleAvatar(
                                backgroundImage: MemoryImage((app).icon))
                            : const CircleAvatar(child: Icon(Icons.apps)),
                        title: Text(app.appName),
                        subtitle: Text(
                            "Usage Time: ${appUsageInfo.usage.inMinutes} min"),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

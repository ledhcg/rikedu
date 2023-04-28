import 'package:flutter/material.dart';
import 'package:rike/src/constants/colors.dart';
import 'package:rike/src/constants/file_strings.dart';
import 'package:rike/src/constants/sizes.dart';
import 'package:rike/src/constants/text_strings.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        title: Text(
          settings,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
        leading: Transform.translate(
          offset: const Offset(p1, 0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            icon: const Icon(FluentIcons.chevron_left_48_filled),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: p1),
        child: Column(
          children: [
            SizedBox(
              width: 120,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(image: AssetImage(avatarDefault)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: p2),
              child: Column(
                children: [
                  Text(
                    "Le Dinh Cuong",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "mail@ledinhcuong.com",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(top: p2, left: p1, right: p1),
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => {},
                      child: const Text(editProfile),
                    ),
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Text(settings),
              leading: Icon(FluentIcons.settings_24_filled),
              trailing: Icon(FluentIcons.chevron_right_24_regular),
            ),
            const ListTile(
              title: Text(language),
              leading: Icon(FluentIcons.earth_24_filled),
              trailing: Icon(FluentIcons.chevron_right_24_regular),
            ),
            const ListTile(
              title: Text(privacyAndSecurity),
              leading: Icon(FluentIcons.lock_closed_24_filled),
              trailing: Icon(FluentIcons.chevron_right_24_regular),
            ),
            const ListTile(
              title: Text(devices),
              leading: Icon(FluentIcons.device_meeting_room_remote_24_filled),
              trailing: Icon(FluentIcons.chevron_right_24_regular),
            ),
            const ListTile(
              title: Text(notificationsAndSounds),
              leading: Icon(FluentIcons.alert_badge_24_filled),
              trailing: Icon(FluentIcons.chevron_right_24_regular),
            ),
            // SwitchListTile(
            //   title: const Text('Airplane Mode'),
            //   secondary: const Icon(Icons.airplanemode_active),
            //   onChanged: (value) {},
            //   value: true,
            // ),
            // SwitchListTile(
            //   title: Text('About'),
            //   secondary: const Icon(FluentIcons.info_24_filled),
            //   onChanged: (value) {},
            //   value: true,
            // ),
            const ListTile(
              title: Text(logout),
              leading: Icon(FluentIcons.panel_left_expand_24_filled),
            )
          ],
        ),
      ),
    );
  }
}

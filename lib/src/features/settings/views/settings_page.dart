import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/models/user_model.dart';
import 'package:rikedu/src/features/settings/controllers/setting_controller.dart';
import 'package:rikedu/src/utils/constants/file_strings.dart';
import 'package:rikedu/src/utils/constants/sizes.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:rikedu/src/features/settings/views/widgets/language_modal.dart';
import 'package:rikedu/src/features/settings/views/widgets/logout_modal.dart';
import 'package:rikedu/src/features/settings/views/widgets/popover.dart';
import 'package:rikedu/src/features/settings/views/widgets/theme_mode_widget.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'settings'.tr,
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
        child: Obx(() {
          User user = controller.user;
          return Column(
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
                      user.fullName,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      user.email,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: p2, left: p1, right: p1),
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => {},
                        child: Text('editProfile'.tr),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('settings'.tr),
                leading: const Icon(FluentIcons.settings_24_filled),
                trailing: const Icon(FluentIcons.chevron_right_24_regular),
                onTap: () => showModalBottomSheet(
                  // barrierColor: rikeAccentColor,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return const Popover(
                      child: SettingsModal(),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text('language'.tr),
                leading: const Icon(FluentIcons.earth_24_filled),
                trailing: const Icon(FluentIcons.chevron_right_24_regular),
                onTap: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return const Popover(
                      child: LanguageModal(),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text('privacyAndSecurity'.tr),
                leading: const Icon(FluentIcons.lock_closed_24_filled),
                trailing: const Icon(FluentIcons.chevron_right_24_regular),
              ),
              ListTile(
                title: Text('devices'.tr),
                leading: const Icon(
                    FluentIcons.device_meeting_room_remote_24_filled),
                trailing: const Icon(FluentIcons.chevron_right_24_regular),
              ),
              ListTile(
                title: Text('notificationsAndSounds'.tr),
                leading: const Icon(FluentIcons.alert_badge_24_filled),
                trailing: const Icon(FluentIcons.chevron_right_24_regular),
              ),
              ListTile(
                title: Text('logout'.tr),
                leading: const Icon(FluentIcons.panel_left_expand_24_filled),
                onTap: () => showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return const Popover(
                      child: LogoutModal(),
                    );
                  },
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

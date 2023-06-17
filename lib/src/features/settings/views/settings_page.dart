import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/news/views/widgets/image_container_widget.dart';
import 'package:rikedu/src/features/settings/controllers/edit_profile_controller.dart';
import 'package:rikedu/src/features/settings/controllers/setting_controller.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:rikedu/src/features/settings/views/widgets/about_modal.dart';
import 'package:rikedu/src/features/settings/views/widgets/language_modal.dart';
import 'package:rikedu/src/features/settings/views/widgets/logout_modal.dart';
import 'package:rikedu/src/features/settings/views/widgets/notifications_and_sounds_modal.dart';
import 'package:rikedu/src/features/settings/views/widgets/popover.dart';
import 'package:rikedu/src/features/settings/views/widgets/privacy_and_security_modal.dart';
import 'package:rikedu/src/features/settings/views/widgets/theme_modal.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';

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
          'Settings'.tr,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: SizesConst.P1),
          child: Obx(() {
            return InfoWidget(
              isSettingMode: controller.isSettingMode,
              changeSettingMode: controller.changeSettingMode,
            );
          }),
        ),
      ),
    );
  }
}

class InfoWidget extends GetView<EditProfileController> {
  const InfoWidget({
    required this.isSettingMode,
    required this.changeSettingMode,
    super.key,
  });

  final bool isSettingMode;
  final VoidCallback changeSettingMode;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Stack(
              fit: StackFit.expand,
              children: [
                controller.file != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(controller.file!.path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      )
                    : ImageContainer(
                        width: double.infinity,
                        height: double.infinity,
                        margin: const EdgeInsets.all(0),
                        borderRadius: 60,
                        isLoading: false,
                        imageUrl: controller.user.avatarUrl,
                      ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        FluentIcons.camera_24_regular,
                        size: 14,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () => controller.selectPhoto(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SizesConst.P2),
            child: Column(
              children: [
                Text(
                  controller.user.fullName,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  controller.user.email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Container(
                  padding: const EdgeInsets.only(
                      top: SizesConst.P2,
                      left: SizesConst.P1,
                      right: SizesConst.P1),
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => changeSettingMode(),
                    child: isSettingMode
                        ? Text('Edit Profile'.tr)
                        : Text('Back to Setting'.tr),
                  ),
                ),
              ],
            ),
          ),
          isSettingMode ? const TabSetting() : const TabEditProfile()
        ],
      ),
    );
  }
}

class TabEditProfile extends GetView<EditProfileController> {
  const TabEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ChangePasswordWidget(),
        Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextFormField(
                  onChanged: (value) => controller.phoneText = value,
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone'.tr,
                    prefixIcon: const Icon(FluentIcons.phone_24_regular),
                  ),
                  validator: controller.validator,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  onChanged: (value) => controller.addressText = value,
                  controller: controller.addressController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Address'.tr,
                    prefixIcon: const Icon(FluentIcons.location_24_regular),
                  ),
                  validator: controller.validator,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  onChanged: (value) => controller.dobText = value,
                  controller: controller.dobController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Department'.tr,
                    prefixIcon: const Icon(FluentIcons.toolbox_24_regular),
                  ),
                  validator: controller.validator,
                ),
                const SizedBox(height: 16.0),
                FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary),
                  onPressed: () {},
                  child: controller.isLoadingUpdateProfile
                      ? Text('Loading'.tr)
                      : Text('Update'.tr),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChangePasswordWidget extends GetView<EditProfileController> {
  const ChangePasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Form(
        key: controller.formChangePasswordKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                onChanged: (value) => controller.setOldPassword(value),
                controller: controller.oldPasswordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isObscure
                          ? FluentIcons.eye_off_24_regular
                          : FluentIcons.eye_24_regular,
                    ),
                    onPressed: controller.toggleObscure,
                  ),
                  prefixIcon: const Icon(FluentIcons.shield_keyhole_24_regular),
                  labelText: 'Old Password'.tr,
                ),
                obscureText: controller.isObscure,
                validator: controller.checkOldPassword,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                onChanged: (value) => controller.setNewPassword(value),
                controller: controller.newPasswordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isObscure
                          ? FluentIcons.eye_off_24_regular
                          : FluentIcons.eye_24_regular,
                    ),
                    onPressed: controller.toggleObscure,
                  ),
                  prefixIcon: const Icon(FluentIcons.key_24_regular),
                  labelText: 'New Password'.tr,
                ),
                obscureText: controller.isObscure,
                validator: controller.passwordValidator,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                onChanged: (value) => controller.setConfirmPassword(value),
                controller: controller.confirmPasswordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isObscure
                          ? FluentIcons.eye_off_24_regular
                          : FluentIcons.eye_24_regular,
                    ),
                    onPressed: controller.toggleObscure,
                  ),
                  prefixIcon: const Icon(FluentIcons.key_reset_24_regular),
                  labelText: 'Confirm New Password'.tr,
                ),
                obscureText: controller.isObscure,
                validator: controller.passwordValidator,
              ),
              const SizedBox(height: 16.0),
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary),
                onPressed: () {
                  controller.updatePassword();
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: controller.isLoadingChangePassword
                    ? Text('Loading'.tr)
                    : Text('Change Password'.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabSetting extends GetView<SettingsController> {
  const TabSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Settings'.tr),
          leading: const Icon(FluentIcons.settings_24_filled),
          trailing: const Icon(FluentIcons.chevron_right_24_regular),
          onTap: () => showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return Popover(
                  child: Obx(() => controller.isStudent
                      ? Column(
                          children: const [
                            ThemeModal(),
                          ],
                        )
                      : Column(
                          children: const [
                            ThemeModal(),
                            MoreSettingsWidget(),
                          ],
                        )));
            },
          ),
        ),
        ListTile(
          title: Text('Language'.tr),
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
          title: Text('Privacy And Security'.tr),
          leading: const Icon(FluentIcons.lock_closed_24_filled),
          trailing: const Icon(FluentIcons.chevron_right_24_regular),
          onTap: () => showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return const Popover(
                child: PrivacyAndSecurityModal(),
              );
            },
          ),
        ),
        ListTile(
          title: Text('Notifications And Sounds'.tr),
          leading: const Icon(FluentIcons.alert_badge_24_filled),
          trailing: const Icon(FluentIcons.chevron_right_24_regular),
          onTap: () => showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return const Popover(
                child: NotificationsAndSoundsModal(),
              );
            },
          ),
        ),
        ListTile(
          title: Text('About'.tr),
          leading: const Icon(FluentIcons.info_24_filled),
          trailing: const Icon(FluentIcons.chevron_right_24_regular),
          onTap: () => showModalBottomSheet(
            isScrollControlled: true,
            useRootNavigator: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) {
              return const Popover(
                child: AboutModal(),
              );
            },
          ),
        ),
        ListTile(
          title: Text('Logout'.tr),
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
  }
}

class MoreSettingsWidget extends GetView<SettingsController> {
  const MoreSettingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SwitchListTile(
            title: Text('Show Map'.tr),
            secondary: const Icon(FluentIcons.map_24_filled),
            onChanged: (isOn) {
              controller.changeSwitchShowMap();
            },
            value: controller.isShowMap,
          ),
          SwitchListTile(
            title: Text('Show Battery'.tr),
            secondary: const Icon(FluentIcons.battery_3_24_filled),
            onChanged: (isOn) {
              controller.changeSwitchShowBattery();
            },
            value: controller.isShowBattery,
          ),
          SwitchListTile(
            title: Text('Show Student Status'.tr),
            secondary: const Icon(FluentIcons.dumbbell_24_filled),
            onChanged: (isOn) {
              controller.changeSwitchShowStudentStatus();
            },
            value: controller.isShowStudentStatus,
          ),
        ],
      ),
    );
  }
}

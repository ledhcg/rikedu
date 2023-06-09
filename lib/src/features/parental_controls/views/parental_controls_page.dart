import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/parental_controls/controllers/parental_controls_controller.dart';
import 'package:rikedu/src/features/parental_controls/views/widgets/map_widget.dart';
import 'package:rikedu/src/features/parental_controls/views/widgets/message_modal.dart';
import 'package:rikedu/src/features/parental_controls/views/widgets/phone_status_widget.dart';
import 'package:rikedu/src/features/settings/views/widgets/popover.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class ParentalControlsPage extends GetView<ParentalControlsController> {
  const ParentalControlsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.35),
                    child: const MapWidget(),
                  ),
                  Positioned(
                    bottom: 100,
                    right: 0,
                    left: 0,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            children: [
                              buildHandleBar(context),
                              const FunctionBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    left: 20,
                    height: 80,
                    child: Obx(
                      () => controller.isLoading
                          ? const LoadingWidget()
                          : const InfoBox(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildHandleBar(BuildContext context) {
  final theme = Theme.of(context);
  return FractionallySizedBox(
    widthFactor: 0.10,
    child: Container(
      margin: const EdgeInsets.only(
        top: 12.0,
      ),
      child: Container(
        height: 5.0,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(2.5)),
        ),
      ),
    ),
  );
}

class FunctionBox extends GetView<ParentalControlsController> {
  const FunctionBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          FunctionItem(
            function: 'App Usage'.tr,
            icon: Icon(
              FluentIcons.apps_48_regular,
              size: 30,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => Get.toNamed(Routes.APP_USAGE),
          ),
          const SizedBox(height: 15),
          FunctionItem(
            function: 'Notifications'.tr,
            icon: Icon(
              FluentIcons.alert_urgent_24_regular,
              size: 30,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => Get.toNamed(Routes.NOTIFICATION),
          ),
          const SizedBox(height: 15),
          FunctionItem(
            function: 'Results'.tr,
            icon: Icon(
              FluentIcons.book_contacts_28_regular,
              size: 30,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => Get.toNamed(Routes.RESULTS),
          ),
          const SizedBox(height: 15),
          FunctionItem(
            function: 'Group'.tr,
            icon: Icon(
              FluentIcons.book_pulse_24_regular,
              size: 30,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => Get.toNamed(Routes.GROUP),
          ),
          const SizedBox(height: 15),
          FunctionItem(
            function: 'Exercises'.tr,
            icon: Icon(
              FluentIcons.box_24_regular,
              size: 30,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => Get.toNamed(Routes.EXERCISE),
          )
        ],
      ),
    );
  }
}

class InfoBox extends GetView<ParentalControlsController> {
  const InfoBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(126.0),
                    child: Image.network(controller.student.avatarUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, top: 8.0, bottom: 4.0),
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          height: 50,
                          child: Text(
                            controller.student.fullName,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          height: 50,
                          child: const PhoneStatusWidget(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  FluentIcons.mail_inbox_add_28_filled,
                  size: 25,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: const Popover(
                        child: MessageModal(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FunctionItem extends StatelessWidget {
  const FunctionItem({
    Key? key,
    required this.function,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String function;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.all(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: icon,
                  )),
              Align(
                alignment: Alignment.center,
                child: Text(
                  function,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

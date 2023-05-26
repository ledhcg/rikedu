import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/parental_controls/controllers/parental_controls_controller.dart';

class MessageDialog extends GetView<ParentalControlsController> {
  const MessageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Create new notification'.tr,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          height: 1.25,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  TextFormField(
                    onChanged: (value) => controller.titleNoti = value,
                    controller: controller.titleController,
                    decoration: InputDecoration(
                      labelText: 'Title'.tr,
                    ),
                    validator: controller.validator,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    onChanged: (value) => controller.messageNoti = value,
                    controller: controller.messageController,
                    decoration: InputDecoration(
                      labelText: 'Message'.tr,
                    ),
                    validator: controller.validator,
                  ),
                  const SizedBox(height: 16.0),
                  FilledButton(
                    onPressed: () => controller.sendNoti(),
                    child: Text('Send'.tr),
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

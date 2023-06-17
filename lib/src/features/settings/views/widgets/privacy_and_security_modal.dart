import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/settings/controllers/privacy_and_security_controller.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyAndSecurityModal extends GetView<PrivacyAndSecurityController> {
  const PrivacyAndSecurityModal({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading
          ? const LoadingWidget()
          : Accordion(
              paddingListBottom: 0,
              maxOpenSections: 2,
              headerBackgroundColorOpened:
                  Theme.of(context).colorScheme.primary,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              scrollIntoViewOfItems: ScrollIntoViewOfItems.fast,
              headerBorderRadius: 30,
              children: [
                AccordionSection(
                  isOpen: false,
                  leftIcon: Icon(FluentIcons.document_lock_24_filled,
                      color: Theme.of(context).colorScheme.onPrimary),
                  headerBackgroundColor: Theme.of(context).colorScheme.primary,
                  headerBackgroundColorOpened:
                      Theme.of(context).colorScheme.primary,
                  header: Text(
                    'Terms And Conditions'.tr,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  content: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: WebViewWidget(
                      gestureRecognizers: {}
                        ..add(Factory(() => VerticalDragGestureRecognizer())),
                      controller: controller.controllerWV,
                    ),
                  ),
                  contentHorizontalPadding: 15,
                  contentBorderRadius: 25,
                  contentBorderWidth: 0,
                ),
                AccordionSection(
                  isOpen: false,
                  leftIcon: Icon(FluentIcons.globe_shield_24_filled,
                      color: Theme.of(context).colorScheme.onPrimary),
                  headerBackgroundColor: Theme.of(context).colorScheme.primary,
                  headerBackgroundColorOpened:
                      Theme.of(context).colorScheme.primary,
                  header: Text(
                    'Privacy Policy'.tr,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  content: SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Container(),
                    // WebViewWidget(
                    //   gestureRecognizers: {}
                    //     ..add(Factory(() => VerticalDragGestureRecognizer())),
                    //   controller: controller.controllerWV,
                    // ),
                  ),
                  contentHorizontalPadding: 15,
                  contentBorderRadius: 25,
                  contentBorderWidth: 0,
                ),
              ],
            ),
    );
  }
}

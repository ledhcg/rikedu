import 'package:flutter/material.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/settings/controllers/language_controller.dart';

class LanguageModal extends GetView<LanguageController> {
  const LanguageModal({super.key});
  @override
  Widget build(BuildContext context) {
    const double sizeFlag = 30;
    const double sizePadding = 10;
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BoxLanguage(
            active: controller.enStatus,
            language: 'English',
            flag: CircleFlag('us', size: sizeFlag),
            onPressed: () {
              controller.updateLanguage(const Locale('en', 'US'));
            },
          ),
          const SizedBox(height: sizePadding),
          BoxLanguage(
            active: controller.ruStatus,
            language: 'Русский',
            flag: CircleFlag('ru', size: sizeFlag),
            onPressed: () {
              controller.updateLanguage(const Locale('ru', 'RU'));
            },
          ),
          const SizedBox(height: sizePadding),
          BoxLanguage(
            active: controller.viStatus,
            language: 'Tiếng Việt',
            flag: CircleFlag('vn', size: sizeFlag),
            onPressed: () {
              controller.updateLanguage(const Locale('vi', 'VN'));
            },
          ),
        ],
      ),
    );
  }
}

class BoxLanguage extends StatelessWidget {
  const BoxLanguage({
    Key? key,
    required this.active,
    required this.language,
    required this.flag,
    required this.onPressed,
  }) : super(key: key);

  final bool active;
  final String language;
  final Widget flag;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ColorFiltered(
          colorFilter: active
              ? const ColorFilter.mode(Colors.transparent, BlendMode.saturation)
              : const ColorFilter.mode(Colors.grey, BlendMode.hue),
          child: FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.all(10.0),
            ),
            child: Stack(
              children: <Widget>[
                Align(alignment: Alignment.centerLeft, child: flag),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    language,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

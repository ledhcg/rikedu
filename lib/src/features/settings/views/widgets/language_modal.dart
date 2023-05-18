import 'package:flutter/material.dart';
import 'package:circle_flags/circle_flags.dart';
import 'package:get/get.dart';

class LanguageModal extends StatefulWidget {
  const LanguageModal({Key? key}) : super(key: key);

  @override
  _LanguageModalState createState() => _LanguageModalState();
}

class _LanguageModalState extends State<LanguageModal> {
  RxBool enStatus = false.obs;
  RxBool viStatus = false.obs;
  RxBool ruStatus = false.obs;

  @override
  void initState() {
    super.initState();
    setLanguageActiveStatus();
  }

  @override
  Widget build(BuildContext context) {
    const double sizeFlag = 30;
    const double sizePadding = 10;
    return Obx(
      () => Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BoxLanguage(
              active: enStatus.value,
              language: 'English',
              flag: CircleFlag('us', size: sizeFlag),
              onPressed: () {
                _updateLocale(const Locale('en', 'US'));
              },
            ),
            const SizedBox(height: sizePadding),
            BoxLanguage(
              active: ruStatus.value,
              language: 'Русский',
              flag: CircleFlag('ru', size: sizeFlag),
              onPressed: () {
                _updateLocale(const Locale('ru', 'RU'));
              },
            ),
            const SizedBox(height: sizePadding),
            BoxLanguage(
              active: viStatus.value,
              language: 'Tiếng Việt',
              flag: CircleFlag('vn', size: sizeFlag),
              onPressed: () {
                _updateLocale(const Locale('vi', 'VN'));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _updateLocale(Locale locale) {
    Get.updateLocale(locale);
    setLanguageActiveStatus();
  }

  bool checkActive(Locale locale) {
    final currentLocale = Get.locale;
    if (currentLocale == locale) return true;
    return false;
  }

  void setLanguageActiveStatus() {
    viStatus.value = checkActive(const Locale('vi', 'VN'));
    enStatus.value = checkActive(const Locale('en', 'US'));
    ruStatus.value = checkActive(const Locale('ru', 'RU'));
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

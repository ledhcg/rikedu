import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rikedu/src/config/routes/app_pages.dart';
import 'package:rikedu/src/features/on_boarding/controllers/on_boarding_controller.dart';
import 'package:rikedu/src/features/settings/views/widgets/language_modal.dart';
import 'package:rikedu/src/features/settings/views/widgets/popover.dart';
import 'package:rikedu/src/features/settings/views/widgets/theme_modal.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';

class OnBoardingPage extends GetView<OnBoardingController> {
  final introKey = GlobalKey<IntroductionScreenState>();
  OnBoardingPage({super.key});

  void _onIntroEnd(context) {
    Get.toNamed(Routes.LOGIN);
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Center(child: Image.asset(assetName, width: width));
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.background;

    const bodyStyle = TextStyle(fontSize: 19.0);

    final pageDecoration = PageDecoration(
      titleTextStyle:
          const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      pageColor: backgroundColor,
      titlePadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      bodyPadding: const EdgeInsets.symmetric(horizontal: 30),
      imagePadding: const EdgeInsets.fromLTRB(0, 50.0, 0, 0),
      imageAlignment: Alignment.center,
      bodyAlignment: Alignment.center,
      imageFlex: 4,
      bodyFlex: 2,
    );

    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          key: introKey,
          globalBackgroundColor: backgroundColor,
          allowImplicitScrolling: true,
          isTopSafeArea: true,
          isBottomSafeArea: true,
          globalHeader: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: TextButton(
                  onPressed: () => showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Popover(
                        child: Column(
                          children: const [
                            ThemeModal(),
                            SizedBox(height: 20),
                            LanguageModal(),
                          ],
                        ),
                      );
                    },
                  ),
                  child: const Icon(
                    FluentIcons.list_28_filled,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          pages: [
            PageViewModel(
              title: "Не упустите",
              body:
                  "Вся информация о учениках в школе будет своевременно и быстро обновляться",
              image: _buildImage(FilesConst.ON_BOARDING_1),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Всегда рядом",
              body:
                  "Родители будут в курсе информации о местоположении, состоянии и уровне использования мобильного устройства своего ребенка",
              image: _buildImage(FilesConst.ON_BOARDING_2),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: "Удобно и быстро",
              body:
                  "Информация обновляется быстро и отображается в реальном времени.",
              image: _buildImage(FilesConst.ON_BOARDING_3),
              footer: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: FilledButton(
                  onPressed: () => {Get.toNamed(Routes.LOGIN)},
                  child: Text(
                    'Login'.tr,
                  ),
                ),
              ),
              decoration: pageDecoration.copyWith(
                bodyFlex: 2,
                imageFlex: 4,
                safeArea: 30,
              ),
            ),
          ],
          onDone: () => _onIntroEnd(context),
          onSkip: () => _onIntroEnd(context),
          showSkipButton: true,
          showDoneButton: false,
          skip: Text('Skip'.tr,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(
            FluentIcons.chevron_right_48_filled,
            size: 30,
          ),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(16),
          controlsPadding:
              kIsWeb ? const EdgeInsets.all(20.0) : const EdgeInsets.all(30.0),
          dotsDecorator: const DotsDecorator(
            size: Size(10.0, 10.0),
            spacing: EdgeInsets.all(2),
            color: Color(0xFFBDBDBD),
            activeSize: Size(30.0, 10.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ),
      ),
    );
  }
}

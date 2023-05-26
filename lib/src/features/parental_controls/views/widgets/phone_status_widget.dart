import 'package:flutter/material.dart';
import 'package:rikedu/src/features/parental_controls/views/widgets/battery_widget.dart';
import 'package:rikedu/src/features/parental_controls/views/widgets/student_active_widget.dart';
import 'package:rikedu/src/utils/constants/colors_constants.dart';

class PhoneStatusWidget extends StatelessWidget {
  const PhoneStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          StudentActiveWidget(),
          VerticalDivider(
            width: 5,
            thickness: 0.5,
            color: rikeDarkColor,
            indent: 10,
            endIndent: 10,
          ),
          BatteryWidget(),
        ],
      ),
    );
  }
}

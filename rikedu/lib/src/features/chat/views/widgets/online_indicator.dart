import 'package:flutter/material.dart';
import 'package:rikedu/src/constants/colors.dart';

class OnlineIndicator extends StatelessWidget {
  const OnlineIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: rikeIndicatorBubble,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          width: 2.0,
          color: rikeLightColor,
        ),
      ),
    );
  }
}

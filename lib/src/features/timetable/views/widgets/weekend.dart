import 'package:flutter/material.dart';
import 'package:rikedu/src/constants/colors.dart';
import 'package:rikedu/src/constants/file_strings.dart';
import 'package:rikedu/src/constants/text_strings.dart';

class WeekendTimetable extends StatelessWidget {
  Color cardColor;
  Color textColor;
  WeekendTimetable({Key? key, required this.cardColor, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
        child: Container(
          color: cardColor,
          padding: const EdgeInsets.all(25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(weekendTimetable),
                  width: 200,
                  height: 200,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                  child: Text(
                    weekend,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: textColor,
                    ),
                  ),
                ),
                Text(
                  haveAGoodDay,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

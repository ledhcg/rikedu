import 'package:flutter/material.dart';
import 'package:rikedu/src/constants/colors.dart';
import 'package:rikedu/src/constants/file_strings.dart';

class WeekendTimetable extends StatelessWidget {
  const WeekendTimetable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shadowColor: Colors.transparent,
        color: rikeLightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Center(
          child: Column(
            children: const [
              Image(
                image: AssetImage(weekendTimetable),
                width: 200,
                height: 200,
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Text(
                  'Weekend',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                'Have a good day!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

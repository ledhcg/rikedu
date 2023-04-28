import 'package:flutter/material.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: const [
        TableRow(
          children: [
            TableCell(
              child: Text('Time'),
            ),
            TableCell(
              child: Text('Monday'),
            ),
            TableCell(
              child: Text('Tuesday'),
            ),
            TableCell(
              child: Text('Wednesday'),
            ),
            TableCell(
              child: Text('Thursday'),
            ),
            TableCell(
              child: Text('Friday'),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Text('8:00 - 9:00'),
            ),
            TableCell(
              child: Text('Math'),
            ),
            TableCell(
              child: Text('Science'),
            ),
            TableCell(
              child: Text('English'),
            ),
            TableCell(
              child: Text('History'),
            ),
            TableCell(
              child: Text('Art'),
            ),
          ],
        ),
      ],
    );
  }
}

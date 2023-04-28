import 'package:flutter/material.dart';
import 'package:rike/src/constants/colors.dart';

class PhoneStatus extends StatelessWidget {
  final Icon iconBattery;
  final bool online;
  final int batteryLevel;
  const PhoneStatus(
      {Key? key,
      required this.batteryLevel,
      required this.online,
      required this.iconBattery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 6.0,
            width: 6.0,
            decoration: BoxDecoration(
              color: rikeIndicatorBubble,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              'Active',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const VerticalDivider(
            width: 5,
            thickness: 0.5,
            color: rikeDarkColor,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(
            height: 32,
            width: 32,
            child: iconBattery,
          ),
          Text(
            '$batteryLevel%',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

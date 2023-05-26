import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget({
    required this.backgroundColor,
    required this.children,
    super.key,
  });

  final Color backgroundColor;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: backgroundColor,
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}

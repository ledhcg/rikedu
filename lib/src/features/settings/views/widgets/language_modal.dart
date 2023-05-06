import 'package:flutter/material.dart';

class LanguageModal extends StatefulWidget {
  const LanguageModal({Key? key}) : super(key: key);

  @override
  _LanguageModalState createState() => _LanguageModalState();
}

class _LanguageModalState extends State<LanguageModal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: Text('Are you sure you want to log out?'),
        ),
        FilledButton(
          onPressed: _logout,
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  void _logout() {
    print('Hello');
  }
}

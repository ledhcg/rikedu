import 'package:flutter/material.dart';
import 'package:rikedu/src/constants/colors.dart';
import 'package:rikedu/src/constants/file_strings.dart';
import 'package:rikedu/src/constants/sizes.dart';
import 'package:rikedu/src/constants/text_strings.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static TextStyle inputTextStyle = const TextStyle(
    color: rikeAccentColor,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(p3),
        child: Column(
          children: [
            const Image(
              image: AssetImage(logo),
              width: 200,
              height: 200,
            ),
            Form(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: p1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: p1),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(FluentIcons.person_mail_24_regular),
                          labelText: email,
                          hintText: email,
                        ),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: p1),
                      child: TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(FluentIcons.password_24_regular),
                          suffixIcon: Icon(FluentIcons.eye_16_regular),
                          labelText: password,
                          hintText: password,
                        ),
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => {},
                        child: const Text(login),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

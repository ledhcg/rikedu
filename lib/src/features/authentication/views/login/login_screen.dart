// import 'package:flutter/material.dart';
// import 'package:rikedu/src/constants/colors.dart';
// import 'package:rikedu/src/constants/file_strings.dart';
// import 'package:rikedu/src/constants/sizes.dart';
// import 'package:rikedu/src/constants/text_strings.dart';
// import 'package:fluentui_system_icons/fluentui_system_icons.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   static TextStyle inputTextStyle = const TextStyle(
//     color: rikeAccentColor,
//     fontWeight: FontWeight.w500,
//     fontSize: 16,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.all(p3),
//         child: Column(
//           children: [
//             const Image(
//               image: AssetImage(logo),
//               width: 200,
//               height: 200,
//             ),
//             Form(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: p1),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: p1),
//                       child: TextFormField(
//                         autofocus: true,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(FluentIcons.person_mail_24_regular),
//                           labelText: email,
//                           hintText: email,
//                         ),
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: p1),
//                       child: TextFormField(
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(FluentIcons.password_24_regular),
//                           suffixIcon: Icon(FluentIcons.eye_16_regular),
//                           labelText: password,
//                           hintText: password,
//                         ),
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       child: FilledButton(
//                         onPressed: () => {},
//                         child: const Text(login),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rikedu/main.dart';
import 'package:rikedu/src/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email address';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      await authService.login(
                        _emailController.text.trim(),
                        _passwordController.text.trim(),
                      );
                      // await authService.connect();
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => const HomePage(
                      //       title: 'Login',
                      //     ),
                      //   ),
                      // );
                      Get.to(
                        const HomePage(
                          title: 'Login',
                        ),
                      );
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())),
                      );
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

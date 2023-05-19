import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rikedu/src/features/authentication/controllers/auth_controller.dart';
import 'package:rikedu/src/utils/constants/files_constants.dart';
import 'package:rikedu/src/utils/constants/sizes_constants.dart';
import 'package:rikedu/src/utils/widgets/loading_widget.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? const LoadingWidget()
            : Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(SizesConst.P3),
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              vertical: SizesConst.P3),
                          child: Image.asset(FilesConst.LOGO_ROUNDED),
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                onChanged: (value) =>
                                    controller.setEmail(value),
                                controller: controller.emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email'.tr,
                                ),
                                validator: controller.emailValidator,
                              ),
                              const SizedBox(height: 16.0),
                              TextFormField(
                                onChanged: (value) =>
                                    controller.setPassword(value),
                                controller: controller.passwordController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isObscure
                                          ? FluentIcons.eye_off_24_filled
                                          : FluentIcons.eye_24_filled,
                                    ),
                                    onPressed: controller.toggleObscure,
                                  ),
                                  labelText: 'Password'.tr,
                                ),
                                obscureText: controller.isObscure,
                                validator: controller.passwordValidator,
                              ),
                              const SizedBox(height: 16.0),
                              FilledButton(
                                onPressed: controller.login,
                                child: Text('Login'.tr),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text('Forgot password?'.tr),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

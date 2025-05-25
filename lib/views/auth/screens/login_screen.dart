import 'dart:io';

import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/controllers/auth_controller.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/services/navigator_services.dart';
import 'package:autoguide/services/validation_services.dart';
import 'package:autoguide/views/auth/screens/forget_password_screen.dart';
import 'package:autoguide/views/general/widgets/custom_button.dart';
import 'package:autoguide/views/general/widgets/custom_text_button.dart';
import 'package:autoguide/views/general/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AutofillGroup(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: authController.signInKey,
            child: SafeArea(
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Text(
                      'AUTOGUIDE',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppStyle.primaryColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      CustomTextField(
                        hint: 'email_address',
                        controller: authController.emailController,
                        autofill: const [AutofillHints.email],
                        validator: ValidationServices.email,
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        hint: 'password',
                        secure: true,
                        controller: authController.passwordController,
                        autofill: const [AutofillHints.password],

                        validator: ValidationServices.password,
                      ),
                      SizedBox(height: 20),
                      ValueListenableBuilder<bool>(
                        valueListenable: authController.loading,
                        builder: (context, loading, child) {
                          return Column(
                            children: [
                              CustomButton(
                                loading: loading,
                                title: 'sign_in',
                                onPressed: () async {
                                  authController.signIn();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      CustomTextButton(
                        title: 'forgotten_password',
                        loading: authController.loading.value,
                        onPressed: () {
                          NavigatorServices.push(ForgetPasswordScreen());
                        },
                      ),
                    ],
                  ),
                  const Spacer(),

                  Row(
                    children: [
                      Expanded(child: Divider(color: AppStyle.primaryColor)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'or'.tr,
                          style: TextStyle(color: AppStyle.primaryColor),
                        ),
                      ),
                      Expanded(child: Divider(color: AppStyle.primaryColor)),
                    ],
                  ),
                  SizedBox(height: 10),
                  if (Platform.isIOS)
                    CustomButton(
                      title: 'sign_in_with_apple',
                      onPressed: () async {
                        authController.appleSignIn();
                      },
                      textColor: Colors.white,
                      color: Colors.black,

                      icon: const Icon(Bootstrap.apple, color: Colors.white),
                    ),
                  if (Platform.isIOS) SizedBox(height: 10),
                  CustomButton(
                    title: 'sign_in_with_google',
                    onPressed: () async {
                      authController.googleSignIn();
                    },
                    textColor: Colors.black,
                    color: Colors.grey.shade300,

                    icon: Brand(Brands.google, size: 30),
                  ),
                  SizedBox(height: 10),
                  CustomButton(
                    title: 'create_new_account',
                    onPressed: () async {},
                    border: true,
                    textColor: AppStyle.primaryColor,
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

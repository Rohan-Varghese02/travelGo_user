import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_button.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_divider.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_header.dart';
import 'package:travelgo_user/features/view/widgets/divider_with_or.dart';
import 'package:travelgo_user/features/view/widgets/heading_password_field.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeader(),
              SizedBox(height: 20),
              HeadingTextField(
                headline: 'Email',
                controller: emailController,
                hint: 'Enter your email address',
              ),
              SizedBox(height: 20),
              HeadingPasswordField(
                headline: 'Password',
                hint: 'Enter your password',
                controller: passController,
                onPressed: () {
                  log('password visible');
                },
              ),
              SizedBox(height: 20),
              // LongButton(
              //   text: 'Login',
              //   onPressed: () {
              //     log('pressed login btn');
              //   },
              // ),
              LoginButton(
                text: 'Login',
                onPressed: () {},
                emailController: emailController,
                passController: passController,
              ),
              SizedBox(height: 20),
              DividerWithOr(),
            ],
          ),
        ),
      ),
    );
  }
}

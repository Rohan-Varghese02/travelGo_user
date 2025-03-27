import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_button.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_footer.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_header.dart';
import 'package:travelgo_user/features/view/widgets/divider_with_or.dart';
import 'package:travelgo_user/features/view/widgets/google_button.dart';
import 'package:travelgo_user/features/view/widgets/heading_password_field.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
                  LoginButton(
                    text: 'Login',
                    onPressed: () {
                      
                    },
                    emailController: emailController,
                    passController: passController,
                  ),
                  SizedBox(height: 20),
                  DividerWithOr(),
                  SizedBox(height: 20),
          
                  GoogleButton(
                    onTap: () {
                      log('Google button pressed functions to be called');
                    },
                  ),
                ],
              ),
              LoginFooter(
                onTap: () {
                  log('Pressed to Join');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

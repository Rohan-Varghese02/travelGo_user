import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_user/features/view/screens/register_screen/widgets/register_button.dart';
import 'package:travelgo_user/features/view/screens/register_screen/widgets/register_header.dart';
import 'package:travelgo_user/features/view/screens/register_screen/widgets/register_tpc.dart';
import 'package:travelgo_user/features/view/widgets/divider_with_or.dart';
import 'package:travelgo_user/features/view/widgets/google_button.dart';
import 'package:travelgo_user/features/view/widgets/heading_password_field.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailRegController = TextEditingController();
    final TextEditingController passRegController = TextEditingController();
    final TextEditingController confirmpassRegController =
        TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
              
              },
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegisterHeader(),
                      SizedBox(height: 20),
                      HeadingTextField(
                        headline: 'Email',
                        controller: emailRegController,
                        hint: 'Enter your email address',
                      ),
                      SizedBox(height: 20),
                      HeadingPasswordField(
                        headline: 'Password',
                        hint: 'Enter your password',
                        controller: passRegController,
                        onPressed: () {},
                      ),
                      SizedBox(height: 20),
                      HeadingPasswordField(
                        headline: 'Confirm Password',
                        hint: 'Confirm your password',
                        controller: confirmpassRegController,
                        onPressed: () {},
                      ),
                      SizedBox(height: 20),
                      RegisterTpc(),
                      SizedBox(height: 20),
                      RegisterButton(
                        text: 'Register',
                        onPressed: () {
                          
                        },
                        emailController: emailRegController,
                        passController: passRegController,
                        confirmPassController: confirmpassRegController,
                      ),
                      SizedBox(height: 20),
                      DividerWithOr(),
                      SizedBox(height: 20),
                      GoogleButton(onTap: () {}),
                    ],
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

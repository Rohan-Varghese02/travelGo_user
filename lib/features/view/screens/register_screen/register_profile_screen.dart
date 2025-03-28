import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_user/features/view/widgets/long_button.dart';

class RegisterProfileScreen extends StatefulWidget {
  final String email;
  final String password;
  const RegisterProfileScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterProfileScreen> createState() => _RegisterProfileScreenState();
}

class _RegisterProfileScreenState extends State<RegisterProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    emailController.text = widget.email;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 25,
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap:
                        () {}, //_pickImage, // Tap on avatar to pick an image
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey[300],
                      child: Icon(Icons.supervised_user_circle_rounded),
                    ),
                  ),
                  SizedBox(height: 20),
                  HeadingTextField(
                    headline: 'Full Name',
                    controller: nameController,
                    hint: 'Enter your name',
                  ),
                  SizedBox(height: 20),
                  HeadingTextField(
                    readOnly: true,
                    headline: 'Email',
                    controller: emailController,
                    hint: 'Enter your name',
                  ),
                  SizedBox(height: 20),
                  HeadingTextField(
                    headline: 'Phone Number',
                    controller: phoneController,
                    hint: 'Enter your phone number',
                  ),
                  SizedBox(height: 20),
                  LongButton(
                    text: 'Register',
                    onPressed: () {
                      log(nameController.text);
                      log(emailController.text);
                      log(phoneController.text);
                      log(widget.password);
                    },
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

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/register_screen/widgets/register_dailog.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';
import 'package:travelgo_user/features/view/widgets/long_button.dart';
import 'package:travelgo_user/features/view/widgets/style_text.dart';

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
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  String? imagePath;
                  String? imageUrl;
                  String? imagePublicId;

                  if (state is ProfileImagePicked) {
                    imagePath = state.imagePath;
                  } else if (state is ProfileImageUploaded) {
                    imagePublicId = state.imagePublicID;
                    imageUrl = state.imageUrl;
                    context.read<AuthBloc>().add(
                      RegisterUser(
                        imagePublicID: imagePublicId,
                        name: nameController.text,
                        email: emailController.text,
                        password: widget.password,
                        phoneNumber: phoneController.text,
                        imageUrl: imageUrl.toString(),
                      ),
                    );
                  } else if (state is RegisterSuccessful) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    });
                  } else if (state is RegisterationError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return RegisterDailog(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    });
                  } else if (state is NoImageState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Upload Photo to proceed')),
                      );
                    });
                  }
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      StyleText(
                        text: 'Profile',
                        size: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 40),

                      GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(PickImageEvent());
                        },
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              imagePath != null
                                  ? FileImage(File(imagePath))
                                  : imageUrl != null
                                  ? NetworkImage(imageUrl) as ImageProvider
                                  : null,
                          child:
                              (imagePath == null && imageUrl == null)
                                  ? Icon(Icons.camera_alt, size: 30)
                                  : null,
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
                          if (imagePath != null) {
                            context.read<AuthBloc>().add(
                              UploadImageEvent(imagePath: imagePath),
                            );
                          } else {
                            context.read<AuthBloc>().add(NoImageEvent());
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

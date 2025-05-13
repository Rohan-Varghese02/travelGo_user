import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelgo_user/core/constants/colors.dart';
import 'package:travelgo_user/data/models/user_data.dart';
import 'package:travelgo_user/features/logic/user/user_bloc.dart';
import 'package:travelgo_user/features/view/screens/pages/profile_page/page_tiles/edit_profile/widgets/profile_avatar.dart';
import 'package:travelgo_user/features/view/widgets/custom_app_bar.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';

class FullProfile extends StatefulWidget {
  final UserDataModel userData;
  const FullProfile({super.key, required this.userData});

  @override
  State<FullProfile> createState() => _FullProfileState();
}

class _FullProfileState extends State<FullProfile> {
  final key_state = GlobalKey<FormState>();
  String? imagePath;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.userData.name;
    emailController.text = widget.userData.email;
    phoneController.text = widget.userData.phoneNumber;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
        color: themeColor,
        showBack: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserBloc>().add(ProfileUpdatIntiate());
            },
            icon: Icon(FontAwesomeIcons.floppyDisk, color: themeColor),
          ),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is ProfileUpdateSuccess) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          // log(imagePath.toString());
          if (state is ProfileImageUpdatedSucess) {
            imagePath = state.imagePath;
            log(imagePath.toString());
          } else if (state is UserProfileIntiated) {
            log('Public ID:${widget.userData.imagePublicID}');
            context.read<UserBloc>().add(
              UpdateProfileEvent(
                imagePublicID: widget.userData.imagePublicID,
                imageUrl: widget.userData.imageUrl,
                uid: widget.userData.uid,
                imagePath: imagePath,
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
              ),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: key_state,
                child: Column(
                  children: [
                    Center(
                      child: ProfileAvatar(
                        imagePath: imagePath,
                        imageUrl: widget.userData.imageUrl,
                        onTap: () {
                          context.read<UserBloc>().add(UpdateImageEvent());
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    HeadingTextField(
                      headline: 'Name',
                      controller: nameController,
                      hint: 'Enter your name',
                      validator: (value) {
                        return textValidator(value);
                      },
                    ),
                    SizedBox(height: 20),

                    HeadingTextField(
                      headline: 'Email',
                      controller: emailController,
                      hint: 'Enter your email',
                      validator: (value) {
                        return textValidator(value);
                      },
                    ),
                    SizedBox(height: 20),

                    HeadingTextField(
                      headline: 'Phone Number',
                      controller: phoneController,
                      hint: 'Enter your phone number',
                      validator: (value) {
                        return textValidator(value);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

String? textValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Fill the Field';
  }
  return null;
}

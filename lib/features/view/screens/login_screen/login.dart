import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_user/features/view/screens/home_screen/home_screen.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_button.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_footer.dart';
import 'package:travelgo_user/features/view/screens/login_screen/widgets/login_header.dart';
import 'package:travelgo_user/features/view/screens/register_screen/register_screen.dart';
import 'package:travelgo_user/features/view/widgets/divider_with_or.dart';
import 'package:travelgo_user/features/view/widgets/google_button.dart';
import 'package:travelgo_user/features/view/widgets/heading_password_field.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
        child: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) => current is! AuthActionState,
            listener: (context, state) {
              if (state is LoginSuccessState) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              } else if (state is LoginFailedState) {
                log(state.error);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              } else if (state is NavigateToRegister) {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    )
                    .whenComplete(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Register successful'),
                        ), // dont forget to change to then whencompleted gives u value even if u dont succed registering
                      );
                    });
              }
            },
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
                    BlocBuilder<AuthBloc, AuthState>(
                      buildWhen:
                          (previous, current) => current is AuthActionState,
                      builder: (context, state) {
                        bool isVisible = true;
                        if (state is VisibleState) {
                          isVisible = state.isVisible;
                        }
                        return HeadingPasswordField(
                          headline: 'Password',
                          hint: 'Enter your password',
                          controller: passController,
                          onPressed: () {
                            context.read<AuthBloc>().add(
                              VisibillityButtonClicked(isVisible: isVisible),
                            );
                            log('password visible');
                          },
                          isVisible: isVisible,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    LoginButton(
                      text: 'Login',
                      onPressed: () {
                        log('pressed');
                        context.read<AuthBloc>().add(
                          CheckLoginEvent(
                            email: emailController.text,
                            password: passController.text,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    DividerWithOr(),
                    SizedBox(height: 20),

                    GoogleButton(onTap: () {}),
                  ],
                ),
                LoginFooter(
                  onTap: () {
                    log('Pressed to Join');
                    context.read<AuthBloc>().add(JoinButtonClicked());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

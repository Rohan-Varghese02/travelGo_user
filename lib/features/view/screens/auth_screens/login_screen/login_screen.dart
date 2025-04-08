import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/core/services/auth/auth_gate.dart';
import 'package:travelgo_user/features/logic/auth/auth_bloc.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/login_screen/widgets/forgot_pass.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/login_screen/widgets/forgot_pass_dailog.dart';
import 'package:travelgo_user/features/view/widgets/auth%20widgets/validator_function.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/login_screen/widgets/login_button.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/login_screen/widgets/login_footer.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/login_screen/widgets/login_header.dart';
import 'package:travelgo_user/features/view/screens/auth_screens/register_screen/register_screen.dart';
import 'package:travelgo_user/features/view/widgets/auth%20widgets/divider_with_or.dart';
import 'package:travelgo_user/features/view/widgets/auth%20widgets/google_button.dart';
import 'package:travelgo_user/features/view/widgets/auth%20widgets/heading_password_field.dart';
import 'package:travelgo_user/features/view/widgets/heading_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passController = TextEditingController();
  final key = GlobalKey<FormState>();
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
              log(state.runtimeType.toString());
              if (state is LoginSuccessState) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AuthGate()),
                );
              } else if (state is LoginFailedState) {
                log(state.error);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Email and Password are incorrect')),
                );
              } else if (state is NavigateToRegister) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              } else if (state is ForgotPasswordState) {
                forgotPasswordDailog(context);
              } else if (state is ResetPasswordSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Email has been sent'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is ResetPasswordFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Invalid Email Address/ It has not been registered',
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LoginHeader(),
                        SizedBox(height: 20),
                        HeadingTextField(
                          headline: 'Email',
                          controller: emailController,
                          hint: 'Enter your email address',
                          validator: (value) {
                            return validateEmail(value);
                          },
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
                              validator: (value) {
                                return validatePassword(value);
                              },
                              headline: 'Password',
                              hint: 'Enter your password',
                              controller: passController,
                              onPressed: () {
                                context.read<AuthBloc>().add(
                                  VisibillityButtonClicked(
                                    isVisible: isVisible,
                                  ),
                                );
                              },
                              isVisible: isVisible,
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        ForgotPass(),
                        SizedBox(height: 20),
                        LoginButton(
                          text: 'Login',
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                CheckLoginEvent(
                                  email: emailController.text,
                                  password: passController.text,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        DividerWithOr(),
                        SizedBox(height: 20),

                        GoogleButton(
                          onTap: () {
                            context.read<AuthBloc>().add(GoogleSignInEvent());
                          },
                        ),
                      ],
                    ),
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
      ),
    );
  }
}

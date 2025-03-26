import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travelgo_user/features/view/screens/landing_screen/widgets/landing_header.dart';
import 'package:travelgo_user/features/view/widgets/long_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              LandingHeader(),
              Lottie.asset('assets/landingpagegif.json'),
              Divider(),
              SizedBox(height: 5),
              LongButton(
                text: 'Get Started',
                onPressed: () {
                  log('Success');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

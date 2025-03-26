import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelgo_user/features/logic/splash/splash_bloc.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  SplashBloc splashBloc = SplashBloc();
  @override
  void initState() {
    super.initState();
    splashBloc.add(IntitalFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: splashBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      child: Scaffold(
        body: Center(child: Image(image: AssetImage('assets/logo3.png'))),
      ),
    );
  }
}

// ignore_for_file: avoid_unnecessary_containers

import 'package:dawini_full/main.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // _navigteToHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: 150,
      curve: Curves.easeInOut,
      duration: 2000,
      splash: Center(
          child: Container(
        child: Image.asset(
          'assets/images/logo.png',
        ),
        // child: const Text(
        //   "DAWINI APP",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //       fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black),
        // ),
      )),
      nextScreen: const MyWidget(),
    );
  }
}

Future<void> _navigteToHome(context) async {
  await Future.delayed(const Duration(seconds: 2));
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => const Splash()));
}

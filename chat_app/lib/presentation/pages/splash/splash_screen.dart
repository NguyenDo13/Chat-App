import 'dart:async';

import 'package:chat_app/presentation/UIData/colors.dart';
import 'package:chat_app/presentation/UIData/dimentions.dart';
import 'package:chat_app/presentation/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), _navigateToHomeScreen);
    super.initState();
  }

  _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              // Colors.deepOrangeAccent,
              redAccent,
              deepPurple,
              // Colors.orangeAccent,
              // Colors.deepPurpleAccent,
              deepPurpleAccent,
            ],
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.height72,
              ),
              Lottie.asset('assets/animations/splash.json'),
              Text(
                'Chit Chat',
                style: GoogleFonts.lobster(
                  color: Colors.white,
                  fontSize: 36,
                ),
              ),
              SizedBox(
                height: Dimensions.height220 - Dimensions.height72,
              ),
              const CircularProgressIndicator(
                color: darkPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

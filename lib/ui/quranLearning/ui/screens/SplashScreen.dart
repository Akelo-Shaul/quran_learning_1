
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/LoginActivity.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/DesignConfig.dart';

class QuranSplashScreen extends StatefulWidget {
  const QuranSplashScreen({Key? key}) : super(key: key);

  @override
  State<QuranSplashScreen> createState() => _QuranSplashScreenState();
}

class _QuranSplashScreenState extends State<QuranSplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginActivity()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: DesignConfig.gradient,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/avatar.jpg',
              height: MediaQuery.of(context).size.width - 130,
            ),
          ),
        ),
      ),
    );
  }
}

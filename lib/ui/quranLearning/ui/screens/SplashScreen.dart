
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/LoginActivity.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/MainActivity.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/DesignConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Constant.dart';

String? user;
class QuranSplashScreen extends StatefulWidget {
  const QuranSplashScreen({Key? key}) : super(key: key);

  @override
  State<QuranSplashScreen> createState() => _QuranSplashScreenState();
}

class _QuranSplashScreenState extends State<QuranSplashScreen> {

  Future<void> checkSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDeats = prefs.getString('user');
    setState(() {
      user = userDeats;
    });
  }

  @override
  void initState() {
    super.initState();

    checkSession().whenComplete(() {
      Timer(const Duration(seconds: 3), () {
        if (user == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginActivity()),
          );
        } else {
          Map<String, dynamic> allUserDeats = jsonDecode(user!);
          Constant.GoToMainPage("login", context, allUserDeats);
        }
      });
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
            gradient: DesignConfig.bannerGradient,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/allogo.png',
              height: MediaQuery.of(context).size.width - 130,
            ),
          ),
        ),
      ),
    );
  }
}

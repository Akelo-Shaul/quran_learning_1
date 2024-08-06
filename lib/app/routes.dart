import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/SplashScreen.dart';



class Routes {
  static const String home = "/";



  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {

    if (routeSettings.name! == home) {
      return CupertinoPageRoute(builder: (_) => const QuranSplashScreen());
    }else {
      return CupertinoPageRoute(builder: (_) => const Scaffold());
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/LoginActivity.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/SplashScreen.dart';



class Routes {
  static const String home = "/";
  static const String login = '/login';


  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {

    if (routeSettings.name! == home) {
      return CupertinoPageRoute(builder: (_) => const QuranSplashScreen());
    }else if(routeSettings.name == login){
      return CupertinoPageRoute(builder: (_) => const LoginActivity());
    }else {
      return CupertinoPageRoute(builder: (_) => const Scaffold());
    }
  }
}
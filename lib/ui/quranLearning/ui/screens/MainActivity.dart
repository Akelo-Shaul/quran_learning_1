import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_learning_1/ui/quranLearning/model/Amount.dart';
import 'package:quran_learning_1/ui/quranLearning/model/Result.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/HomePage.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/LoginActivity.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/ProfileActivity.dart';

import 'package:quran_learning_1/ui/quranLearning/ui/screens/ResultsStudentWebView.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/ResultsWebView.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/ColorsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/Constant.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/DesignConfig.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/StringsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/UIData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../app/routes.dart';

Result? selectedresult;
Amount? selectedamount;

StreamController<String>? countstream;

GlobalKey<ScaffoldState>? scafolldmain;

List<Result>? mainresultlist;
List<Amount>? mainamountlist;


class MainActivity extends StatefulWidget {
  final String from;
  final int selectedPosition;
  final Map<String, dynamic> data;

  MainActivity({required this.from, required this.selectedPosition, required this.data, Key? key}) : super(key: key);

  @override
  MainActivityState createState() => MainActivityState(this.from);
}

class MainActivityState extends State<MainActivity> {
  final String from;
  int? selectedPos;
  Color homeStatusbarcolor = ColorsRes.statusbarcolor;

  String get displayName => widget.data['fullname'] ?? 'User';

  MainActivityState(this.from);

  late final Map<String, dynamic> data;

  Future<void> checkSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');

    if (user != null) {
      // Session is valid, proceed with loading the main content
    } else {
      // No session token, redirect to login page
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.login,
            (route) => false,
      );
    }
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user'); // Clear the session token

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.login,
          (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    data = widget.data;

    checkSession();

    mainamountlist = UIData.getAmountList();
    mainresultlist = UIData.getResultList();

    scafolldmain = GlobalKey<ScaffoldState>();

    selectedPos = widget.selectedPosition;
  }

  @override
  void dispose() {
    countstream?.close();
    super.dispose();
  }

  void currentPagePosition(int position) {
    homeStatusbarcolor = (position == 0 || position == 2)
        ? ColorsRes.statusbarcolor
        : ColorsRes.bgcolor;
    setState(() {
      selectedPos = position;
    });
  }

  Widget setBottomNavigation(int? pos, BuildContext bcontext) {
    return BottomAppBar(
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: ColorsRes.white,
          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () => currentPagePosition(0),
              child: SvgPicture.asset(
                pos == 0
                    ? 'assets/images/selectedhome.svg'
                    : 'assets/images/home.svg',
                height: pos == 0
                    ? MediaQuery.of(context).size.width / 8
                    : MediaQuery.of(context).size.width / 14,
              ),
            ),
            GestureDetector(
              onTap: () => currentPagePosition(1),
              child: SvgPicture.asset(
                pos == 1
                    ? 'assets/images/selectedhistory.svg'
                    : 'assets/images/history.svg',
                height: pos == 1
                    ? MediaQuery.of(context).size.width / 8
                    : MediaQuery.of(context).size.width / 14,
              ),
            ),
            GestureDetector(
              onTap: () => currentPagePosition(2),
              child: SvgPicture.asset(
                pos == 2
                    ? 'assets/images/selectedprofile.svg'
                    : 'assets/images/profile.svg',
                height: pos == 2
                    ? MediaQuery.of(context).size.width / 8
                    : MediaQuery.of(context).size.width / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bodyContainer() {
    final Map<String, dynamic> data = widget.data;

    String userType = data['user_type'] ?? 'Student';

    switch (selectedPos) {
      case 0:
        return HomePage(data: data);
      case 1:
        return userType == 'Teacher'
            ? ResultsWebView(userId: widget.data['userID'], data: widget.data, showBottomNavigationBar: false,)
            : ResultsStudentWebView(userId: widget.data['userID'], data: widget.data,showBottomNavigationBar: false,);
      case 2:
        return ProfileActivity(data: data);
      default:
        return HomePage(data: data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(statusBarColor: homeStatusbarcolor),
        child: Scaffold(
          key: scafolldmain,
          bottomNavigationBar: setBottomNavigation(selectedPos, context),
          drawer: Drawer(
            child: drawerData(),
          ),
          body: bodyContainer(),
        ),
      ),
    );
  }

  Widget drawerData() {
    var width = MediaQuery.of(context).size.width / 8;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: DesignConfig.gradient,
          ),
          padding: const EdgeInsets.only(top: 50, bottom: 15),
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              if (Platform.isIOS) BackButton(color: ColorsRes.white),
              Container(
                width: 85,
                height: 85,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(45.0)),
                  border: Border.all(
                    color: ColorsRes.appcolor,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Constant.ImageWidget(UIData.profileimage, 81, 81),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${displayName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsRes.white,
                      ),
                    ),
                    Text(
                      'The email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorsRes.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/drhome.svg",
                  height: MediaQuery.of(context).size.width / 14,
                ),
                title: Text(
                  StringsRes.profile,
                  style: TextStyle(color: ColorsRes.appcolor),
                ),
                subtitle: Divider(
                  color: ColorsRes.appcolor,
                  endIndent: 40,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileActivity(data: data,)));
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/logout.svg",
                  height: MediaQuery.of(context).size.width / 14,
                ),
                title: Text(StringsRes.logout,
                    style: TextStyle(color: ColorsRes.appcolor)),
                subtitle: Divider(
                  color: ColorsRes.appcolor,
                  endIndent: 40,
                ),
                onTap: () {
                  Navigator.pop(context);
                  //Constant.session.logoutUser(context);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: DesignConfig.roundedrectangleshape,
                        title: Text(
                          StringsRes.logout,
                          style: TextStyle(
                            color: ColorsRes.secondgradientcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(StringsRes.logoutconfirm),
                        actions: [
                          TextButton(
                            child: Text(
                              StringsRes.cancel,
                              style: TextStyle(color: ColorsRes.secondgradientcolor),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              StringsRes.logout,
                              style: TextStyle(color: ColorsRes.secondgradientcolor),
                            ),
                            onPressed: () {
                              logout();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}




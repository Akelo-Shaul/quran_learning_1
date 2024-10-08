// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/ColorsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/Constant.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/DesignConfig.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/StringsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/UIData.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/new_dialog.dart';
import 'package:quran_learning_1/ui/snippets/helper/octoBlurHash.dart';
import 'package:shared_preferences/shared_preferences.dart';



TextStyle? textStyle;
final _scaffoldKey = GlobalKey<ScaffoldState>();

class ProfileActivity extends StatefulWidget {

  final Map<String, dynamic> data;

  const ProfileActivity({required this.data, Key? key}) : super(key: key);

  @override
  ProfileActivityState createState() => ProfileActivityState();
}

class ProfileActivityState extends State<ProfileActivity>
    with SingleTickerProviderStateMixin {
  double topheight = 250;

  String get displayName => widget.data['fullname'] ?? 'User';

  String? from;
  @override
  void initState() {
    super.initState();
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_token'); // Clear the session token

    Navigator.pushNamedAndRemoveUntil(
      context,
      "/login",
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    textStyle = Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
      fontWeight: FontWeight.w500,
      color: ColorsRes.appcolor,
    ));

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      key: _scaffoldKey,
      backgroundColor: ColorsRes.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          SizedBox(
            height: topheight,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    height: topheight,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(bottom: 50),
                      child: Image.asset(
                        'assets/images/profileback.png',
                        fit: BoxFit.fill,
                      )
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    backgroundColor: ColorsRes.white,
                    radius: 55,
                    child: Stack(children: [
                      CircleAvatar(
                        radius: 47,
                        child: ClipOval(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Constant.ImageWidget(UIData.profileimage, 95, 95),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          Center(
              child: Text(
                  // UIData.username,
                '${displayName}',
                  style: Theme.of(context).textTheme.titleLarge!.merge(TextStyle(
                      color: ColorsRes.black, fontWeight: FontWeight.bold)))),
          Center(
              child: Text(
                  // UIData.useremail,
                'The student Id',
                  style: Theme.of(context).textTheme.titleSmall!.merge(TextStyle(
                    color: ColorsRes.black,
                  )))),
          Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 20, right: 10),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("fee Balance",
                              style: TextStyle(
                                color: ColorsRes.black,
                              )),
                          Text(
                              "KSH 4000",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .merge(TextStyle(
                                  color: ColorsRes.firstgradientcolor,
                                  fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ),
                    VerticalDivider(color: ColorsRes.black),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Last Result",
                              style: TextStyle(
                                color: ColorsRes.black,
                              )),
                          Text(
                              "Chapter 3 -5",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .merge(TextStyle(
                                  color: ColorsRes.firstgradientcolor,
                                  fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Divider(
            color: ColorsRes.firstgradientcolor,
            thickness: 1,
            endIndent: 30,
            indent: 30,
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 10),
            child: Text(
              StringsRes.lblgeneral,
              style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
                  color: ColorsRes.black, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    showNewDialog(
                        context: context,
                        builder: (context) => const ChangePswDialog());
                  },
                  leading: SvgPicture.asset(
                    'assets/images/pro_account.svg',
                    height: MediaQuery.of(context).size.width / 16,
                  ),
                  title: Text(StringsRes.change_password,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  dense: true,
                ),
                ListTile(
                  onTap: () {
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
                  leading: SvgPicture.asset(
                    'assets/images/pro_logout.svg',
                    height: MediaQuery.of(context).size.width / 16,
                  ),
                  title: Text(StringsRes.logout,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: ColorsRes.red)),
                  dense: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChangePswDialog extends StatefulWidget {
  const ChangePswDialog({Key? key}) : super(key: key);

  @override
  ChangePswAlert createState() => ChangePswAlert();
}

class ChangePswAlert extends State<ChangePswDialog> {
  late BuildContext _scaffoldContext;
  bool iserror = false,
      iserrornew = false,
      iserrorcpsw = false,
      isotperr = false,
      isbtnvisible = true;
  TextEditingController? oldpsw, newpsw, cpsw; //,otp;
  bool isdialogloading = false;
  String? cpswerrtext;

  @override
  initState() {
    oldpsw = TextEditingController();
    //otp = new TextEditingController();
    newpsw = TextEditingController();
    cpsw = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    return OpenChangePswDialog();
  }

  Container titleheader() {
    return Container(
      color: ColorsRes.white,
      width: double.maxFinite,
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        "${StringsRes.change_password} ?",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: ColorsRes.secondgradientcolor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  OpenChangePswDialog() {
    bool obscureTextold = true, obscureTextnew = true, obscureTextcm = true;
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: DesignConfig.roundedrectangleshape,
        insetPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.close,
                  color: ColorsRes.grey,
                ),
              ),
            ),
            titleheader(),
            Container(
                margin: const EdgeInsetsDirectional.only(top: 20),
                alignment: Alignment.centerLeft,
                child: Text("\tEnter Old Password",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            color: ColorsRes.black,
                            fontWeight: FontWeight.bold)))),
            TextField(
              obscureText: obscureTextold,
              controller: oldpsw,
              decoration: InputDecoration(
                hintText: "Enter Old Password",
                errorText: iserror ? 'Old password not matched' : null,
                isDense: true,
                focusedBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                disabledBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                enabledBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                errorBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureTextold = !obscureTextold;
                    });
                  },
                  child: Icon(
                    obscureTextold ? Icons.visibility : Icons.visibility_off,
                    color: ColorsRes.grey,
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsetsDirectional.only(top: 10),
                alignment: Alignment.centerLeft,
                child: Text("\t${StringsRes.enter_new_password}",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            color: ColorsRes.black,
                            fontWeight: FontWeight.bold)))),
            TextField(
              obscureText: obscureTextnew,
              controller: newpsw,
              decoration: InputDecoration(
                hintText: StringsRes.enter_new_password,
                errorText:
                iserrornew ? StringsRes.password_length_warning : null,
                focusedBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                disabledBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                enabledBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                errorBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                isDense: true,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureTextnew = !obscureTextnew;
                    });
                  },
                  child: Icon(
                    obscureTextnew ? Icons.visibility : Icons.visibility_off,
                    color: ColorsRes.grey,
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsetsDirectional.only(top: 10),
                alignment: Alignment.centerLeft,
                child: Text("\t${StringsRes.enter_confirm_password}",
                    style: Theme.of(context).textTheme.titleSmall!.merge(
                        TextStyle(
                            color: ColorsRes.black,
                            fontWeight: FontWeight.bold)))),
            TextField(
              obscureText: obscureTextcm,
              controller: cpsw,
              decoration: InputDecoration(
                hintText: StringsRes.enter_confirm_password,
                errorText: iserrorcpsw ? cpswerrtext : null,
                focusedBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                disabledBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                enabledBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                errorBorder:
                DesignConfig.Setoutlineborderedittext(ColorsRes.grey, 5),
                isDense: true,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      obscureTextcm = !obscureTextcm;
                    });
                  },
                  child: Icon(
                    obscureTextcm ? Icons.visibility : Icons.visibility_off,
                    color: ColorsRes.grey,
                  ),
                ),
              ),
            ),
            !isbtnvisible
                ? Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                StringsRes.otp_send,
                style: TextStyle(
                    color: ColorsRes.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )
                : Container(),
            isdialogloading
                ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            )
                : Container(),
            const SizedBox(
              height: 15,
            ),
            Row(children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(BorderSide(
                        width: 2, color: ColorsRes.secondgradientcolor)),
                    padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
                  ),
                  //textColor: ColorsRes.secondgradientcolor,
                  //shape: DesignConfig.SetRoundedBorder(ColorsRes.secondgradientcolor, 5),
                  child: Text(StringsRes.cancel,
                      style: TextStyle(
                        color: ColorsRes.secondgradientcolor,
                      )),
                  onPressed: () {
                    Navigator.of(_scaffoldContext).pop();
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: ColorsRes.white, backgroundColor: ColorsRes
                      .secondgradientcolor, /*textStyle: TextStyle(fontSize: 24, fontStyle: FontStyle.italic)*/
                  ),
                  //textColor: ColorsRes.white,
                  //color: ColorsRes.secondgradientcolor,
                  //shape: DesignConfig.SetRoundedBorder(ColorsRes.secondgradientcolor, 5),
                  child: Text(StringsRes.change,
                      style: TextStyle(
                        color: ColorsRes.white,
                      )),
                  onPressed: () async {
                    Navigator.of(_scaffoldContext).pop();
                  },
                ),
              ),
            ])
          ]),
        ),
      );
    });
  }
}

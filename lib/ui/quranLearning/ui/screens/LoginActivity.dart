// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/ColorsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/Constant.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/DesignConfig.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/StringsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/ease_in_widget.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/new_dialog.dart';



GlobalKey<ScaffoldState>? scaffoldKey;

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginActivityState();
  }
}

class LoginActivityState extends State<LoginActivity> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController edtusername = TextEditingController();
  TextEditingController edtpsw = TextEditingController();
  TextEditingController forgotedtemail = TextEditingController();

  final bool _obscureText = true;
  bool isLoading = false, isdialogloading = false;

  @override
  void initState() {
    super.initState();

    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    double toppadding = 2 * kToolbarHeight;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: ColorsRes.bgcolor,
          shadowColor: Colors.transparent,
        ),
        backgroundColor: ColorsRes.bgcolor,
        key: scaffoldKey,
        body: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: toppadding,
                        ),
                        Image.asset(
                          'assets/images/defaultprofile.png',
                          // color: ColorsRes.appcolor,
                          height: width - 100,
                        ),
                        Container(
                          decoration: DesignConfig.BoxDecorationContainer(
                              ColorsRes.editboxcolor, 10),
                          margin: const EdgeInsets.only(top: 30),
                          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          child: TextFormField(
                            style: const TextStyle(color: ColorsRes.appcolor),
                            cursorColor: ColorsRes.appcolor,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: StringsRes.enter_username,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          ColorsRes.appcolor.withOpacity(0.5))),
                              border: InputBorder.none,
                              errorStyle: const TextStyle(color: ColorsRes.grey),
                            ),
                            keyboardType: TextInputType.text,
                            controller: edtusername,
                          ),
                        ),
                        Container(
                          decoration: DesignConfig.BoxDecorationContainer(
                              ColorsRes.editboxcolor, 10),
                          margin: const EdgeInsets.only(top: 12),
                          padding: const EdgeInsets.only(left: 10, right: 5),
                          child: TextFormField(
                            obscureText: _obscureText,
                            controller: edtpsw,
                            validator: (val) =>
                                val!.isEmpty ? StringsRes.password : null,
                            style: const TextStyle(color: ColorsRes.appcolor),
                            cursorColor: ColorsRes.appcolor,
                            decoration: InputDecoration(
                              hintText: StringsRes.password,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .merge(TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          ColorsRes.appcolor.withOpacity(0.5))),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              showNewDialog(
                                  context: context,
                                  builder: (context) => const ForgotDialog());
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 2),
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "${StringsRes.forgot_password} ?",
                                style: const TextStyle(
                                    color: ColorsRes.firstgradientcolor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        isLoading
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ))
                            : Container(),
                        EaseInWidget(
                          onTap: () async {
                            Constant.GoToMainPage("login", context);
                          },
                          child: DesignConfig.ButtonWithShadowNew(
                              StringsRes.login.toUpperCase(), context),
                        ),

                        const SizedBox(height: 12),
                        SizedBox(
                          height: toppadding - 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotDialog extends StatefulWidget {
  const ForgotDialog({Key? key}) : super(key: key);

  @override
  ForgotAlert createState() => ForgotAlert();
}

class ForgotAlert extends State<ForgotDialog> {
  late BuildContext _scaffoldContext;
  bool iserror = false;
  TextEditingController? forgotedtemail;
  bool isdialogloading = false;

  @override
  initState() {
    forgotedtemail = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldContext = context;
    return OpenForgotDialog();
  }

  OpenForgotDialog() {
    return AlertDialog(
      title: Text(StringsRes.forgot_password),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: forgotedtemail,
            decoration: InputDecoration(
              hintText: "Enter Email",
              errorText: iserror ? 'Enter Valid Email Address' : null,
            ),
          ),
          isdialogloading ? const CircularProgressIndicator() : Container(),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text(StringsRes.recover_password),
          onPressed: () async {},
        ),
        TextButton(
          child: Text(StringsRes.cancel),
          onPressed: () {
            Navigator.of(_scaffoldContext).pop();
          },
        ),
      ],
    );
  }
}

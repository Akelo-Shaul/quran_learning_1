// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

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

  bool _obscureText = true;
  bool isLoading = false;
  bool isdialogloading = false;

  String? username, password;

  Future<http.Response> loginAPI(String user, String pass) async {
    final response = await http.get(Uri.parse(
        'https://alasheikquranlearningsystem.citycloudschool.co.ke/allapis/login.php?username=${user}&password=${pass}'));

    if (response.statusCode == 200) {
      return response;
    } else {
      // throw Exception('Failed to login: ${response.statusCode}');
      return response;
    }
  }

  FocusNode usernameFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void dispose() {
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
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
                          height: width - 200,
                        ),
                        Container(
                          decoration: DesignConfig.BoxDecorationContainer(
                              ColorsRes.editboxcolor, 10),
                          margin: const EdgeInsets.only(top: 30),
                          padding:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5),
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
                                  color: ColorsRes.appcolor.withOpacity(0.5))),
                              border: InputBorder.none,
                              errorStyle: const TextStyle(color: ColorsRes.grey),
                            ),
                            keyboardType: TextInputType.text,
                            controller: edtusername,
                            focusNode: usernameFocusNode,
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
                            focusNode: passwordFocusNode,
                            keyboardType: TextInputType.text,
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
                                  color: ColorsRes.appcolor.withOpacity(0.5))),
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
                          ),
                        )
                            : Container(),
                        EaseInWidget(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });

                            try {
                              username = edtusername.text;
                              password = edtpsw.text;


                              var response = await loginAPI(username!, password!);
                              var decodedResponse = json.decode(response.body);

                              print(decodedResponse['code'].runtimeType);

                              if (decodedResponse['code'] == 200) {
                                print('Redirecting to main page');
                                Constant.GoToMainPage("login", context);
                              } else {
                                if(decodedResponse['message'] == 'Username not provided'){
                                  FocusScope.of(context).requestFocus(usernameFocusNode);
                                }else if(decodedResponse['message'] == 'Username or Password Incorrect'){
                                  FocusScope.of(context).requestFocus(passwordFocusNode);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Incorrect username or password',),
                                      margin: EdgeInsets.only(bottom: 50),
                                    ),
                                  );

                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(decodedResponse['message'])),
                                  );
                                }
                                print("Login failed: ${response.statusCode}");
                              }
                            } catch (e) {
                              print("Error: $e");
                            } finally {
                              setState(() {
                                isLoading = false;
                              });
                            }
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
          onPressed: () async {
            // Implement password recovery logic
          },
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

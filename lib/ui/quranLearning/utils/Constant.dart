
// import 'package:smartkit_pro/ui/fullApps/cryptoTech/ui/screens/MainActivity.dart';
// import 'package:smartkit_pro/ui/fullApps/cryptoTech/utils/ColorsRes.dart';


import 'package:flutter/material.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/MainActivity.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Constant {
  static String CURRENCYNAME = "Shilling";
  static String CURRENCYSYMBOL = "Ksh";
  static String USCURRENCYSYMBOL = "\$";

  static String Filter_all = 'all';
  static String Filter_today = 'today';
  static String Filter_week = 'week';
  static String Filter_month = 'month';
  static String Filter_year = 'year';

  static String perfectmoney = "Perfect Money";
  static String paxfulbitcoin = "Paxful Bitcoin";
  static String btc = "BTC";
  static String eth = "ETH";
  static String ltct = "LTCT";
  static String ltc = "LTC";
  static String usd = "USD";
  static String usdt = "USDT";
  static String pm = "PM";

  static void GoToMainPage(String from, BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainActivity(from, 0)),
            (Route<dynamic> route) => false);
  }


  static Widget ImageWidget(String path, double imgheight, double imgwidth) {
    String extensiondata = path.trim().isEmpty ? '' : path.split(".").last;

    if (path.trim().isEmpty) {
      return WebsafeSvg.asset(
        "assets/images/avatar/defaultprofile.svg",
        height: imgheight,
        width: imgwidth,
        fit: BoxFit.fill,
      );
    } else if (extensiondata == 'svg') {
      return WebsafeSvg.asset(path,
          height: imgheight,
          width: imgwidth,
          fit: BoxFit.fill,
          placeholderBuilder: (BuildContext context) => WebsafeSvg.asset(
              "assets/images/avatar/defaultprofile.svg",
              fit: BoxFit.fill,
              height: imgheight,
              width: imgwidth));
    } else {
      return FadeInImage.assetNetwork(
          image: path,
          height: imgheight,
          width: imgwidth,
          fit: BoxFit.fill,
          placeholder: "assets/images/defaultprofile.png");
    }
  }

  static String setFirstLetterUppercase(String? value) {
    return value == null || value.isEmpty
        ? ""
        : "${value[0].toUpperCase()}${value.substring(1).toLowerCase()}";
  }

  static String SetStatuswithSplit(String? value) {
    if (value == null || value.isEmpty) return "";

    List<String> data = value.split("_");
    String mainvalue = "";
    for (int i = 0; i < data.length; i++) {
      mainvalue = mainvalue + " " + setFirstLetterUppercase(data[i]);
    }
    return value == null || value.isEmpty ? "" : mainvalue;
  }

  static String DisplayDateTime(String senddate, bool withtime) {
    var date =
    new DateTime.fromMillisecondsSinceEpoch(int.parse(senddate) * 1000);

    if (withtime) {
      return DateFormat('dd/MM/yyyy hh:mm:ss a').format(date);
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }

  static String DisplayDateTimeyearText(String senddate) {
    var date =
    new DateTime.fromMillisecondsSinceEpoch(int.parse(senddate) * 1000);
    DateTime currdate = new DateTime.now();

    if (currdate.year == date.year) {
      return DateFormat('MMM dd').format(date);
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}
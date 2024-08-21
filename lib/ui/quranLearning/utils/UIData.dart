import 'package:quran_learning_1/ui/quranLearning/model/Amount.dart';
import 'package:quran_learning_1/ui/quranLearning/model/Result.dart';
import 'package:quran_learning_1/ui/quranLearning/model/SliderImage.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UIData {

  static String userimage =
      "assets/images/avatar/avatar-12.svg";

  // static List<String> sliderimglist = [
  //   "assets/images/fullApps/cryptotech/slider1-min.png",
  //   "assets/images/fullApps/cryptotech/slider2-min.png",
  //   "assets/images/fullApps/cryptotech/slider3-min.png",
  //   "assets/images/fullApps/cryptotech/slider4-min.png",
  // ];

  static List<SliderImage> getSliderImageList() {
    List<SliderImage> sliderimagelist = [];
    for (Map model in sliderimagedata) {
      SliderImage sliderImage =
      SliderImage.fromJson(model as Map<String, dynamic>);
      sliderimagelist.add(sliderImage);
    }
    return sliderimagelist;
  }

  static List<Map<String, String>> sliderimagedata = [
    {
      "id": "1",
      "image":
      "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/cryptotech%2Fslider1.jpg?alt=media&token=4292f550-8cbb-490f-8b21-163decfd8567",
      "blurUrl": "L99sfN.AtT}eS]XQX4fS0JMznnA8",
      "localimg": "assets/images/fullApps/cryptotech/slider1.jpg",
    },
    {
      "id": "2",
      "image":
      "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/cryptotech%2Fslider2.jpg?alt=media&token=03e59602-466f-497e-8184-d823609d6e15",
      "blurUrl": "LXN_1NH=t-*0~CtmRjRPyYx]ROMd",
      "localimg": "assets/images/fullApps/cryptotech/slider2.jpg",
    },
    {
      "id": "3",
      "image":
      "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/cryptotech%2Fslider3.jpg?alt=media&token=41348f0b-73f3-46fc-b201-1d9bde5f135d",
      "blurUrl": "LHCi3A_d-s]p7-9qKcR\$E1\$%xbIt",
      "localimg": "assets/images/fullApps/cryptotech/slider3.jpg",
    },
    {
      "id": "4",
      "image":
      "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/cryptotech%2Fslider4.jpg?alt=media&token=45ba8ff5-bce2-4ef0-b0df-2869eead0ea2",
      "blurUrl": "LaPG,8Q+X.L4~CtlRiV?PDTKi_rV",
      "localimg": "assets/images/fullApps/cryptotech/slider4.jpg",
    },
    {
      "id": "5",
      "image":
      "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/cryptotech%2Fslider5.jpg?alt=media&token=8571b8b5-e507-42bf-bf44-6b83b4a149ed",
      "blurUrl": "LMQv%f~W_300_NE1Mxxu^,R%M{%N",
      "localimg": "assets/images/fullApps/cryptotech/slider5.jpg",
    },
  ];


  static List<Result> getResultList() {
    List<Result> resultlist = [];
    for (Map model in resultdata) {
      Result result = Result.fromHomeJson(model as Map<String, String>);
      resultlist.add(result);
    }
    return resultlist;
  }

  static List<Amount> getAmountList() {
    List<Amount> amountlist = [];
    for (Map model in amountdata) {
      amountlist.add(Amount.fromAmountJson(model as Map<String, String>));
    }
    return amountlist;
  }

  static List<Map<String, String>> resultdata = [
    {
      "date": "2024-01-01",
      "chapter": "Al-Fatiha",
      "studentName": "Ahmed",
      "verse": "1-7",
    },
    {
      "date": "2024-02-01",
      "chapter": "Al-Baqarah",
      "studentName": "Fatima",
      "verse": "1-10",
    },
    {
      "date": "2024-03-01",
      "chapter": "Al-Imran",
      "studentName": "Yusuf",
      "verse": "1-5",
    },
  ];

  static List<Map<String, String>> amountdata = [
    {
      "amount": "50",
      "date": "2024-01-01",
    },
    {
      "amount": "100",
      "date": "2024-02-01",
    },
    {
      "amount": "150",
      "date": "2024-03-01",
    },
  ];
}

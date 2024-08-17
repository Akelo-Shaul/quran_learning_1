import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:octo_image/octo_image.dart';
import 'package:quran_learning_1/ui/quranLearning/model/Amount.dart';
import 'package:quran_learning_1/ui/quranLearning/model/Result.dart';
import 'package:quran_learning_1/ui/quranLearning/model/SliderImage.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/HistoryActivity.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/MainActivity.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/ColorsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/Constant.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/DesignConfig.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/ImageSlider.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/StringsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/UIData.dart';
import 'package:quran_learning_1/ui/snippets/helper/octoBlurHash.dart';


List<SliderImage>? sliderimagelist;

class HomePage extends StatefulWidget {

  final Map<String, dynamic> data;

  HomePage({required this.data, Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String get displayName => widget.data['fullname'] ?? 'User';

  int msgcount = 2;
  double leftrightpadding = 20;
  bool ispm = true,
      ispaxbit = true,
      isbtc = true,
      iseth = true,
      isltct = true,
      isltc = true,
      isusdt = true;

  @override
  void initState() {
    sliderimagelist = [];
    sliderimagelist = UIData.getSliderImageList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: homePageContent());
  }

  Widget homePageContent() {
    return SingleChildScrollView(
      child: Column(children: <Widget>[
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: const [
                        ColorsRes.secondgradientcolor,
                        ColorsRes.firstgradientcolor
                      ])),
              margin: const EdgeInsets.only(bottom: 25),
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: GestureDetector(
                        onTap: () {
                          scafolldmain!.currentState!.openDrawer();
                        },
                        child: SvgPicture.asset(
                          'assets/images/drawer_button.svg',
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, top: 10, bottom: 10),
                    child: Row(children: [
                      Card(
                        shape: DesignConfig.SetRoundedBorder(
                            ColorsRes.appcolor, 10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: OctoImage(
                          image: const CachedNetworkImageProvider(
                              "https://firebasestorage.googleapis.com/v0/b/smartkit-8e62c.appspot.com/o/cryptotech%2Fprofilepic.jpg?alt=media&token=2be2819f-6007-4763-a727-cb93f08f460c"),
                          placeholderBuilder: OctoBlurHashFix.placeHolder(
                            "LNIX]g_3.TIU%NRjRPxukXR*s9of",
                          ),
                          width: 60,
                          height: 60,
                          errorBuilder: OctoError.icon(color: ColorsRes.black),
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(greeting(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .merge(TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsRes.white,
                                  ))),
                              Text('${displayName}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .merge(TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ColorsRes.white,
                                  ))),
                            ]),
                      )
                    ]),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          top: 15, bottom: 15, left: 20, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text("\t\t${StringsRes.walletbalance}",
                                Text("Fee BalancE",
                                    style: TextStyle(
                                        color: ColorsRes.white.withOpacity(0.7),
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Text("\t\t${Constant.CURRENCYSYMBOL}",
                                        style: TextStyle(
                                            color: ColorsRes.white
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w600)),
                                    // Text("\t${UIData.walletbalance}",
                                      Text('50000',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .merge(TextStyle(
                                            color: ColorsRes.white,
                                            fontWeight: FontWeight.w600))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Text("\t\t${StringsRes.bankingbalance}",
                                Text('Last Results',
                                      style: TextStyle(
                                        color: ColorsRes.white.withOpacity(0.7),
                                        fontWeight: FontWeight.bold)),
                                Row(
                                  children: [
                                    Text("\t\t${Constant.CURRENCYSYMBOL}",
                                        style: TextStyle(
                                            color: ColorsRes.white
                                                .withOpacity(0.7),
                                            fontWeight: FontWeight.w600)),
                                    // Text("\t${UIData.bankbalance}",
                                    Text("Benki balanci",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .merge(TextStyle(
                                            color: ColorsRes.white,
                                            fontWeight: FontWeight.w600))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  shape: DesignConfig.SetRoundedBorder(Colors.white, 10),
                  color: ColorsRes.white,
                  margin: EdgeInsets.only(
                      left: leftrightpadding, right: leftrightpadding),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HistoryActivity(0)));
                            //     builder: (context) => SellActivity(1, -1)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    "assets/images/buycoins.svg",
                                    height:
                                    MediaQuery.of(context).size.width / 16),
                                const SizedBox(width: 10),
                                Text(
                                  // StringsRes.buycoin,
                                  'Results',
                                  style: TextStyle(
                                      color: ColorsRes.firstgradientcolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => SellActivity(0, -1)));
                                builder: (context) => HistoryActivity(2)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/sellcoins.svg",
                                  height:
                                  MediaQuery.of(context).size.width / 16,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  // StringsRes.sellcoin,
                                  'Fee Statement',
                                  style: TextStyle(
                                      color: ColorsRes.firstgradientcolor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              right: leftrightpadding, left: leftrightpadding, top: 10),
          child: ImageSliderWidget(
            from: "main",
            imageUrls: sliderimagelist,
            imageBorderRadius: BorderRadius.circular(15),
            imageHeight: 180.0,
            isfeatured: false,
          ),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 10, left: leftrightpadding, right: leftrightpadding),
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(
                    // StringsRes.recent_transaction,
                    'Recent Results',
                    style:
                    Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
                      color: ColorsRes.hometitlecolor,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ), // Defaults to a flex of one.
                GestureDetector(
                  child: Text(StringsRes.lblmore,
                      style: TextStyle(
                        color: ColorsRes.viewallcolor,
                        fontWeight: FontWeight.w300,
                      )),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HistoryActivity(0)));
                  },
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10, left: leftrightpadding, right: leftrightpadding),
              child: resultListWidget(),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 20, left: leftrightpadding, right: leftrightpadding),
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(
                  'Fee Statement',
                    style:
                    Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
                      color: ColorsRes.hometitlecolor,
                      fontWeight: FontWeight.w600,
                    )),
                  ),
                ),
                GestureDetector(
                  child: Text(StringsRes.lblmore,
                      style: TextStyle(
                        color: ColorsRes.viewallcolor,
                        fontWeight: FontWeight.w300,
                      )),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HistoryActivity(2)));
                  },
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10, left: leftrightpadding, right: leftrightpadding),
              child: feeListWidget(),
            ),
          ],
        ),
      ]),
    );
  }

  Widget resultListWidget() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: ColorsRes.grey,
          endIndent: 3,
          indent: 3,
          thickness: 0.8,
          height: 0,
        ),
        padding: const EdgeInsets.only(bottom: 8),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: mainresultlist!.length > 5 ? 5 : mainresultlist!.length,
        itemBuilder: (BuildContext context, int index) {
          Result result = mainresultlist![index];

          //TODO: Edit and uncomment
          return GestureDetector(
              child: Card(
                shape: DesignConfig.SetRoundedBorder(ColorsRes.white, 5),
                margin: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(Constant.setFirstLetterUppercase(result.studentName),
                          style: Theme.of(context).textTheme.bodySmall!.merge(
                              TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green))
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: Text(
                            '${result.chapter}',
                            style: Theme.of(context).textTheme.titleMedium!.merge(
                                TextStyle(
                                    color: ColorsRes.appcolor,
                                    fontWeight: FontWeight.w700,
                                ),
                            )
                          )
                        ),
                        Text(
                          // Constant.DisplayDateTimeyearText(
                          //     transaction.created_on!),
                          'Result Date',
                          style: Theme.of(context).textTheme.bodySmall!.merge(
                              TextStyle(
                                  color: ColorsRes.grey.withOpacity(0.6),
                                  fontWeight: FontWeight.bold)),
                        ),
                      ]),
                    ],
                  ),
                ),
              ));
        });
  }

  Widget feeListWidget() {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: ColorsRes.grey,
          endIndent: 3,
          indent: 3,
          thickness: 0.8,
          height: 0,
        ),
        padding: const EdgeInsets.only(bottom: 8),
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: mainamountlist!.length > 5 ? 5 : mainamountlist!.length,
        itemBuilder: (BuildContext context, int index) {
          Amount amount = mainamountlist![index];


          return GestureDetector(
              child: Card(
                shape: DesignConfig.SetRoundedBorder(ColorsRes.white, 5),
                margin: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // Constant.setFirstLetterUppercase(
                        //     transaction.crypto_currency_type),
                        'Student name',
                        style: Theme.of(context).textTheme.bodySmall!.merge(
                            TextStyle(
                                color: ColorsRes.green,
                                fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              // "${Constant.CURRENCYSYMBOL}${transaction.naira_amount}",
                            '${amount.amount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .merge(TextStyle(
                                  color: ColorsRes.appcolor,
                                  fontWeight: FontWeight.w700))),
                          Text(
                            // Constant.DisplayDateTimeyearText(
                            //     transaction.created_on!),
                            '${amount.date}',
                            style: Theme.of(context).textTheme.bodySmall!.merge(
                                TextStyle(
                                    color: ColorsRes.grey.withOpacity(0.6),
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                // selectedtrade = transaction;
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => TradeDetail("main")));
              });
        });
  }


  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return StringsRes.goodmorning;
    } else if (hour < 17) {
      return StringsRes.goodafternoon;
    } else if (hour < 21) {
      return StringsRes.goodevening;
    } else {
      return StringsRes.goodnight;
    }
  }
}

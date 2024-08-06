// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_learning_1/ui/quranLearning/model/Amount.dart';
import 'package:quran_learning_1/ui/quranLearning/model/Result.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/MainActivity.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/ColorsRes.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/Constant.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/DecoratedTabBar.dart';
import 'package:quran_learning_1/ui/quranLearning/utils/StringsRes.dart';


final _scaffoldKeyoutgoing = GlobalKey<ScaffoldState>();

class HistoryActivity extends StatefulWidget {
  int tabindex;

  HistoryActivity(this.tabindex, {Key? key}) : super(key: key);

  @override
  HistoryState createState() => HistoryState(tabindex);
}

class HistoryState extends State<HistoryActivity>
    with TickerProviderStateMixin {

  //TODO: Evaluate code block
  String? selectedClass;
  DateTime selectedDate = DateTime.now();
  String? selectedTime;

  String? selectedStudent, selectedChapter;
  final List<String> classes = ['Class 1', 'Class 2', 'Class 3'];
  final List<String> times = ['Morning', 'Midday', 'Evening'];
  final List<Map<String, dynamic>> students = [
    {'name': 'Student 1', 'status': 'absent'},
    {'name': 'Student 2', 'status': 'present'},
    {'name': 'Student 3', 'status': 'absent'},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: ColorsRes.firstgradientcolor, // selected date color
              onPrimary: Colors.white, // selected date text color
              onSurface: ColorsRes.secondgradientcolor, // unselected date text color
            ),
          ),
          child: child!,
        );
      },
    ).then((picked) {
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    });
  }

  void _showStudentList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              // Set a fixed height for the bottom sheet to push it lower on the screen
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.95, // Adjust this value as needed
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30,right: 16, left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Student Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16
                            )
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Absent',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        SizedBox(width: 16), // Space between absent and present headers
                        Expanded(
                          child: Text(
                            'Present',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: students.length,
                        itemBuilder: (context, index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  students[index]['name'],
                                  style: TextStyle(
                                      fontSize: 16
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Checkbox(
                                      value: students[index]['status'] == 'absent',
                                      onChanged: (bool? value) {
                                        setModalState(() {
                                          students[index]['status'] = value == true
                                              ? 'absent'
                                              : 'present';
                                        });
                                      },
                                      checkColor: Colors.white,
                                      activeColor: Colors.purple,
                                      side: BorderSide(
                                        color: Colors.purple,
                                        width: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    Checkbox(
                                      value: students[index]['status'] == 'present',
                                      onChanged: (bool? value) {
                                        setModalState(() {
                                          students[index]['status'] = value == true
                                              ? 'present'
                                              : 'absent';
                                        });
                                      },
                                      checkColor: Colors.white,
                                      activeColor: Colors.purple,
                                      side: BorderSide(
                                        color: Colors.purple,
                                        width: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.purple,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  //todo: end of code block

  TabController? tabController;
  int tabindex;
  //HistoryState(this.tabindex);
  List<Result>? resultlist;
  List<Amount>? paidamountlist;

  int resultsoffset = 0, paidamountoffset = 0;
  ScrollController? resultcontroller, paidamountcontroller;
  bool resultsisloadmore = true,
      paidamountisloadmore = true,
      resultisgettingdata = true,
      paidamountisgettingdata = true,
      resultisnodata = false,
      paidamountisnodata = false;

  String transactiontimefilter = Constant.Filter_all;
  String tradetimefilter = Constant.Filter_all;


  static String title = StringsRes.history;

  Widget appBarTitle = Text(
    title,
    style: const TextStyle(color: Colors.black),
  );

  Icon iconsearch = const Icon(
    Icons.search,
    color: Colors.black,
  );
  final TextEditingController _controller = TextEditingController();

  String _searchText = "", _lastsearch = "";
  final FocusNode filterFocus = FocusNode();

  bool _isSearching = false;

  HistoryState(this.tabindex) {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }

      if (_lastsearch != _searchText) {
        _lastsearch = _searchText;

        if (tabController!.index == 0) {
          ReloadTransactionData();
        } else {
          ReloadTradeData();
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();

    resultlist = [];
    paidamountlist = [];

    resultlist = mainresultlist;
    paidamountlist = mainamountlist;

    tabController =
        TabController(length: 3, vsync: this, initialIndex: tabindex);

    _isSearching = false;
    resultsoffset = 0;
    paidamountoffset = 0;
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(
          color: ColorsRes.black,
        ),
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: ColorsRes.bgcolor,
        centerTitle: true,
        title: appBarTitle,
        bottom: DecoratedTabBar(
          tabBar: TabBar(
            controller: tabController,
            labelStyle: TextStyle(
              color: ColorsRes.hometitlecolor,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
            unselectedLabelStyle: TextStyle(
              color: ColorsRes.grey,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.5,
            ),
            unselectedLabelColor: ColorsRes.datecolor,
            labelColor: ColorsRes.firstgradientcolor,
            indicatorColor: ColorsRes.bgcolor,
            tabs: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Tab(text: StringsRes.result)),
              Align(
                alignment: Alignment.center,
                child: Tab(text: StringsRes.attendance,),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Tab(text: StringsRes.feeStatement)),
            ],
          ),
          bgcolor: ColorsRes.bgcolor,
          decoration: null,
        ),
        actions: <Widget>[
          IconButton(
            icon: iconsearch,
            onPressed: () {
              setState(() {
                if (iconsearch.icon == Icons.search) {
                  iconsearch = const Icon(
                    Icons.close,
                    color: Colors.black,
                  );
                  appBarTitle = TextField(
                    autofocus: true,
                    controller: _controller,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.black),
                        hintText: "Search...",
                        hintStyle: TextStyle(color: Colors.black)),
                    // onChanged: searchOperation,
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]);
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      iconsearch = const Icon(
        Icons.search,
        color: Colors.black,
      );
      appBarTitle = Text(
        title,
        style: const TextStyle(color: Colors.black),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKeyoutgoing,
        backgroundColor: ColorsRes.white,
        appBar: buildAppBar(context) as PreferredSizeWidget?,
        body: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
          child: TabBarView(
            controller: tabController,
            children: [
              ResultContent(),
              AttendanceContent(),
              FeeContent(),
            ],
          ),
        ),
      ),
    );
  }

  ReloadTransactionData() {
    resultsisloadmore = true;
    resultsoffset = 0;
  }

  ReloadTradeData() {
    paidamountisloadmore = true;
    paidamountoffset = 0;
  }

  Widget ResultContent() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RecordResults(),
            Wrap(spacing: 10, children: [
              GestureDetector(
                  onTap: () {
                    if (transactiontimefilter != Constant.Filter_today) {
                      setState(() {
                        transactiontimefilter = Constant.Filter_today;
                      });
                      ReloadTransactionData();
                    }
                  },
                  child: Text(
                    StringsRes.filtertoday,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: transactiontimefilter == Constant.Filter_today
                            ? ColorsRes.firstgradientcolor
                            : ColorsRes.grey.withOpacity(0.7)),
                  )),
              GestureDetector(
                  onTap: () {
                    if (transactiontimefilter != Constant.Filter_week) {
                      setState(() {
                        transactiontimefilter = Constant.Filter_week;
                      });
                      ReloadTransactionData();
                    }
                  },
                  child: Text(
                    StringsRes.filterweek,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: transactiontimefilter == Constant.Filter_week
                            ? ColorsRes.firstgradientcolor
                            : ColorsRes.grey.withOpacity(0.7)),
                  )),
              GestureDetector(
                  onTap: () {
                    if (transactiontimefilter != Constant.Filter_month) {
                      setState(() {
                        transactiontimefilter = Constant.Filter_month;
                      });
                      ReloadTransactionData();
                    }
                  },
                  child: Text(
                    StringsRes.filtermonth,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: transactiontimefilter == Constant.Filter_month
                            ? ColorsRes.firstgradientcolor
                            : ColorsRes.grey.withOpacity(0.7)),
                  )),
              GestureDetector(
                  onTap: () {
                    if (transactiontimefilter != Constant.Filter_year) {
                      setState(() {
                        transactiontimefilter = Constant.Filter_year;
                      });
                      ReloadTransactionData();
                    }
                  },
                  child: Text(
                    StringsRes.filteryear,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: transactiontimefilter == Constant.Filter_year
                            ? ColorsRes.firstgradientcolor
                            : ColorsRes.grey.withOpacity(0.7)),
                  )),
              GestureDetector(
                  onTap: () {
                    if (transactiontimefilter != Constant.Filter_all) {
                      setState(() {
                        transactiontimefilter = Constant.Filter_all;
                      });
                      ReloadTransactionData();
                    }
                  },
                  child: Text(
                    StringsRes.filterall,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: transactiontimefilter == Constant.Filter_all
                            ? ColorsRes.firstgradientcolor
                            : ColorsRes.grey.withOpacity(0.7)),
                  )),
            ]),
            const SizedBox(height: 10),
            ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 25,
                  color: ColorsRes.bgcolor,
                ),
                padding: const EdgeInsetsDirectional.only(
                    bottom: 5, start: 5, end: 5, top: 12),
                controller: resultcontroller,
                physics: const ClampingScrollPhysics(),
                itemCount: resultlist!.length,
                itemBuilder: (context, index) {
                  Result result = resultlist![index];

                  return GestureDetector(
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  // Constant.SetStatuswithSplit(result.chapter)
                                  //     .trim(),
                                  'Student name',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(TextStyle(
                                      color: ColorsRes.hometitlecolor,
                                      fontWeight: FontWeight.bold)),
                                ),
                                Text(
                                    Constant.setFirstLetterUppercase(
                                        result.chapter),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .merge(TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red))),
                                        // color:Constant.StatusColor(
                                        //     transaction.status!)))),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                                '${result.date}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .merge(TextStyle(
                                    color: ColorsRes.datecolor,
                                    fontWeight: FontWeight.w700)),
                                textAlign: TextAlign.end),
                          ],
                        ),
                      ]),
                  );
            }),
          ],
        ),
      ),
    );
  }

  Widget AttendanceContent() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        return true;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            AttendanceSelect(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(spacing: 10, children: [
                  GestureDetector(
                      onTap: () {
                        if (transactiontimefilter != Constant.Filter_today) {
                          setState(() {
                            transactiontimefilter = Constant.Filter_today;
                          });
                          ReloadTransactionData();
                        }
                      },
                      child: Text(
                        StringsRes.filtertoday,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: transactiontimefilter == Constant.Filter_today
                                ? ColorsRes.firstgradientcolor
                                : ColorsRes.grey.withOpacity(0.7)),
                      )),
                  GestureDetector(
                      onTap: () {
                        if (transactiontimefilter != Constant.Filter_week) {
                          setState(() {
                            transactiontimefilter = Constant.Filter_week;
                          });
                          ReloadTransactionData();
                        }
                      },
                      child: Text(
                        StringsRes.filterweek,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: transactiontimefilter == Constant.Filter_week
                                ? ColorsRes.firstgradientcolor
                                : ColorsRes.grey.withOpacity(0.7)),
                      )),
                  GestureDetector(
                      onTap: () {
                        if (transactiontimefilter != Constant.Filter_month) {
                          setState(() {
                            transactiontimefilter = Constant.Filter_month;
                          });
                          ReloadTransactionData();
                        }
                      },
                      child: Text(
                        StringsRes.filtermonth,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: transactiontimefilter == Constant.Filter_month
                                ? ColorsRes.firstgradientcolor
                                : ColorsRes.grey.withOpacity(0.7)),
                      )),
                  GestureDetector(
                      onTap: () {
                        if (transactiontimefilter != Constant.Filter_year) {
                          setState(() {
                            transactiontimefilter = Constant.Filter_year;
                          });
                          ReloadTransactionData();
                        }
                      },
                      child: Text(
                        StringsRes.filteryear,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: transactiontimefilter == Constant.Filter_year
                                ? ColorsRes.firstgradientcolor
                                : ColorsRes.grey.withOpacity(0.7)),
                      )),
                  GestureDetector(
                      onTap: () {
                        if (transactiontimefilter != Constant.Filter_all) {
                          setState(() {
                            transactiontimefilter = Constant.Filter_all;
                          });
                          ReloadTransactionData();
                        }
                      },
                      child: Text(
                        StringsRes.filterall,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: transactiontimefilter == Constant.Filter_all
                                ? ColorsRes.firstgradientcolor
                                : ColorsRes.grey.withOpacity(0.7)),
                      )),
                ]),
                const SizedBox(height: 10),
                ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) => Divider(
                      height: 25,
                      color: ColorsRes.bgcolor,
                    ),
                    padding: const EdgeInsetsDirectional.only(
                        bottom: 5, start: 5, end: 5, top: 12),
                    controller: resultcontroller,
                    physics: const ClampingScrollPhysics(),
                    itemCount: resultlist!.length,
                    itemBuilder: (context, index) {
                      Result result = resultlist![index];

                      return GestureDetector(
                          child: Row(children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5, right: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      Constant.SetStatuswithSplit(result.chapter)
                                          .trim(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .merge(TextStyle(
                                          color: ColorsRes.hometitlecolor,
                                          fontWeight: FontWeight.bold)),
                                    ),
                                    Text(
                                        'Morning',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .merge(TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red))),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                    "Present",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(TextStyle(
                                        color: ColorsRes.green,
                                        fontWeight: FontWeight.w700)),
                                    textAlign: TextAlign.end),
                                Text(
                                  // Constant.DisplayDateTimeyearText(
                                  //     result.date!),
                                    '${result.date}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .merge(TextStyle(
                                        color: ColorsRes.datecolor,
                                        fontWeight: FontWeight.w700)),
                                    textAlign: TextAlign.end),
                              ],
                            ),
                          ]));
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget FeeContent() {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        return true;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(spacing: 10, children: [
            GestureDetector(
                onTap: () {
                  if (tradetimefilter != Constant.Filter_today) {
                    setState(() {
                      tradetimefilter = Constant.Filter_today;
                    });
                    ReloadTradeData();
                  }
                },
                child: Text(
                  StringsRes.filtertoday,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tradetimefilter == Constant.Filter_today
                          ? ColorsRes.firstgradientcolor
                          : ColorsRes.grey.withOpacity(0.7)),
                )),
            GestureDetector(
                onTap: () {
                  if (tradetimefilter != Constant.Filter_week) {
                    setState(() {
                      tradetimefilter = Constant.Filter_week;
                    });
                    ReloadTradeData();
                  }
                },
                child: Text(
                  StringsRes.filterweek,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tradetimefilter == Constant.Filter_week
                          ? ColorsRes.firstgradientcolor
                          : ColorsRes.grey.withOpacity(0.7)),
                )),
            GestureDetector(
                onTap: () {
                  if (tradetimefilter != Constant.Filter_month) {
                    setState(() {
                      tradetimefilter = Constant.Filter_month;
                    });
                    ReloadTradeData();
                  }
                },
                child: Text(
                  StringsRes.filtermonth,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tradetimefilter == Constant.Filter_month
                          ? ColorsRes.firstgradientcolor
                          : ColorsRes.grey.withOpacity(0.7)),
                )),
            GestureDetector(
                onTap: () {
                  if (tradetimefilter != Constant.Filter_year) {
                    setState(() {
                      tradetimefilter = Constant.Filter_year;
                    });
                    ReloadTradeData();
                  }
                },
                child: Text(
                  StringsRes.filteryear,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tradetimefilter == Constant.Filter_year
                          ? ColorsRes.firstgradientcolor
                          : ColorsRes.grey.withOpacity(0.7)),
                )),
            GestureDetector(
                onTap: () {
                  if (tradetimefilter != Constant.Filter_all) {
                    setState(() {
                      tradetimefilter = Constant.Filter_all;
                    });
                    ReloadTradeData();
                  }
                },
                child: Text(
                  StringsRes.filterall,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: tradetimefilter == Constant.Filter_all
                          ? ColorsRes.firstgradientcolor
                          : ColorsRes.grey.withOpacity(0.7)),
                )),
          ]),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 25,
                  color: ColorsRes.bgcolor,
                ),
                padding: const EdgeInsetsDirectional.only(
                    bottom: 5, start: 5, end: 5, top: 12),
                controller: paidamountcontroller,
                physics: const ClampingScrollPhysics(),
                itemCount: paidamountlist!.length,
                itemBuilder: (context, index) {
                  Amount amount = paidamountlist![index];

                  return GestureDetector(
                      child: Row(children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${Constant.CURRENCYSYMBOL} ${Constant.setFirstLetterUppercase(
                                      amount.amount)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .merge(TextStyle(
                                      color: ColorsRes.hometitlecolor,
                                      fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "paid",
                            style: Theme.of(context).textTheme.titleSmall!.merge(
                                TextStyle(
                                    color: ColorsRes.green,
                                    fontWeight: FontWeight.w700)),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                // Constant.DisplayDateTimeyearText(
                                //     amount.date as String),
                                '${amount.date}',
                                style:
                                Theme.of(context).textTheme.bodySmall!.merge(
                                  TextStyle(
                                      color: ColorsRes.datecolor,
                                      fontWeight: FontWeight.w700),
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ]),
                      );
                }),
          ),
        ],
      ),
    );
  }

  Widget AttendanceSelect(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedClass,
            hint: Text('Select Class'),
            items: classes.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedClass = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Class',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            controller: TextEditingController(
              text: "${selectedDate.toLocal()}".split(' ')[0],
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedTime,
            hint: Text('Select Time'),
            items: times.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedTime = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Time',
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (selectedClass != null && selectedTime != null) {
                _showStudentList(context);
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget RecordResults(){
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: selectedStudent,
            hint: Text('Select Student'),
            items: students.map((student) {
              return DropdownMenuItem<String>(
                value: student['name'], // or any unique identifier you have
                child: Text(student['name']), // or any property to display
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedStudent = newValue;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Student',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            readOnly: true,
            onTap: () => _selectDate(context),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Date',
              suffixIcon: Icon(Icons.calendar_today),
            ),
            controller: TextEditingController(
              text: "${selectedDate.toLocal()}".split(' ')[0],
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  value: selectedChapter,
                  hint: Text('Select Chapter'),
                  items: students.map((student) {
                    return DropdownMenuItem<String>(
                      value: 'chapter', // or any unique identifier you have
                      child: Text('Chapter'), // or any property to display
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedChapter = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Chapter',
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  value: selectedChapter,
                  hint: Text('Select Chapter'),
                  items: students.map((student) {
                    return DropdownMenuItem<String>(
                      value: 'verse', // or any unique identifier you have
                      child: Text('verse'), // or any property to display
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedChapter = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Verse',
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              //TODO: Send the results to the results list
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

}


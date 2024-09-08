import 'package:flutter/material.dart';
import 'package:quran_learning_1/ui/quranLearning/ui/screens/MainActivity.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/ColorsRes.dart';

class PaymentRecordsWebView extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> data;

  const PaymentRecordsWebView({Key? key, required this.userId, required this.data}) : super(key: key);

  @override
  _PaymentRecordsWebViewState createState() => _PaymentRecordsWebViewState();
}

class _PaymentRecordsWebViewState extends State<PaymentRecordsWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse('https://www.alasheikquranlearningsystem.com/~main/payments_records.php?user_id=${widget.userId}'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Records'),
      ),
      body: WebViewWidget(controller: _controller),
      bottomNavigationBar: setBottomNavigation(1, context),
    );
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
              onTap: () => Navigator.of(bcontext).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MainActivity(
                    from: '/results_web_view',
                    selectedPosition: 0,
                    data: widget.data,
                  ),
                ),
                    (Route<dynamic> route) => false,
              ),
              child: SvgPicture.asset(
                pos == 0
                    ? 'assets/images/selectedhome.svg'
                    : 'assets/images/home.svg',
                height: pos == 0
                    ? MediaQuery.of(bcontext).size.width / 8
                    : MediaQuery.of(bcontext).size.width / 14,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(bcontext).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MainActivity(
                    from: '/results_web_view',
                    selectedPosition: 1,
                    data: widget.data,
                  ),
                ),
                    (Route<dynamic> route) => false,
              ),
              child: SvgPicture.asset(
                pos == 1
                    ? 'assets/images/selectedhistory.svg'
                    : 'assets/images/history.svg',
                height: pos == 1
                    ? MediaQuery.of(bcontext).size.width / 8
                    : MediaQuery.of(bcontext).size.width / 14,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(bcontext).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => MainActivity(
                    from: '/results_web_view',
                    selectedPosition: 2,
                    data: widget.data,
                  ),
                ),
                    (Route<dynamic> route) => false,
              ),
              child: SvgPicture.asset(
                pos == 2
                    ? 'assets/images/selectedprofile.svg'
                    : 'assets/images/profile.svg',
                height: pos == 2
                    ? MediaQuery.of(bcontext).size.width / 8
                    : MediaQuery.of(bcontext).size.width / 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

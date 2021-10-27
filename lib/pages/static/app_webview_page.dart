import 'package:flutter/material.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 7/8/2021 8:41 PM
///
class AppWebViewPage extends StatefulWidget {
  static const routeName = '/AppWebViewPage';

  const AppWebViewPage({Key? key}) : super(key: key);

  @override
  _AppWebViewPageState createState() => _AppWebViewPageState();
}

class _AppWebViewPageState extends State<AppWebViewPage> {
  late String url, appBarName;

  @override
  void initState() {
    super.initState();
    final map = (Get.arguments ?? {}) as Map<String, dynamic>;
    url = map['url'] ?? '';
    appBarName = map['title'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appBarName,
        ),
      ),
//       body: WebView(
//         javascriptMode: JavascriptMode.unrestricted,
//         initialUrl: url,
//         onWebViewCreated: (WebViewController webViewController) {
// //          _controller = webViewController;
//         },
//       ),
    );
  }
}

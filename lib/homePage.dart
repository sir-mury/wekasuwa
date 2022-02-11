// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController controller;
  final isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          // Stay in app
          return false;
        } else if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          // exit from app
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
              initialUrl: 'https://www.wekasuwa.com/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                this.controller = controller;
              }),
        ),
        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: Colors.orange[800],
            overlayOpacity: 0.5,
            spacing: 10.0,
            spaceBetweenChildren: 8.0,
            openCloseDial: isDialOpen,
            children: [
              SpeedDialChild(
                child: Icon(Icons.cached),
                label: 'Refresh',
                onTap: () => controller.reload(),
              ),
              SpeedDialChild(
                child: Icon(Icons.clear_all_outlined),
                label: 'Cache & Cookies',
                onTap: () {
                  controller.clearCache();
                  CookieManager().clearCookies();
                },
              ),
            ]),
      ),
    );
  }
}

// child: Scaffold(
//         body: SafeArea(
//           child: ModalProgressHUD(
//             progressIndicator: const CircularProgressIndicator(
//               color: Colors.orange,
//             ),
//             inAsyncCall: spinner,
//             child: WebView(
//                 initialUrl: 'https://www.wekasuwa.com/',
//                 javascriptMode: JavascriptMode.unrestricted,
//                 onPageFinished: (finished) {
//                   setState(() {
//                     spinner = false;
//                   });
//                 },
//                 onWebViewCreated: (controller) {
//                   this.controller = controller;
//                 }),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const FaIcon(
//             FontAwesomeIcons.retweet,
//             size: 24,
//           ),
//           backgroundColor: Colors.orange[700],
//           foregroundColor: Colors.white,
//           splashColor: Colors.red,
//           onPressed: () => controller.reload(),
//         ),
//       ),

// child: FloatingActionButton(
//             child: FaIcon(
//               FontAwesomeIcons.retweet,
//               size: 24,
//             ),
//             backgroundColor: Colors.orange[700],
//             foregroundColor: Colors.white,
//             splashColor: Colors.red,
//             onPressed: () => controller.reload(),
//           ),

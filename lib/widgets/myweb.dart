import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:literahub/core/theme/light_colors.dart';

class MyWebViewScreen extends StatefulWidget {
  String url;
  String title;
  MyWebViewScreen({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<MyWebViewScreen> {
  late final WebViewController _webviewController;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }
  

  @override
  Widget build(BuildContext context) {
    print('-----------------URL ${widget.url}');
    return PopScope(
      onPopInvoked: (didPop) async {
          debugPrint('onPopInvoked is getting called - $didPop');
          WebViewController webViewController = await _controller.future;
          if (didPop && await webViewController.canGoBack()) {
            webViewController.goBack();
          } else {
            Navigator.pop(context);
          }
        },
        canPop:  false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(color: Colors.black54),
            ), // You can add title here
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor:
                Colors.blue.withOpacity(0.3), //You can make this transparent
            elevation: 0.0, //No shadow
          ),
          body: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (c) {
                _webviewController = c;
                _controller.complete(c);
                print("cleaning the cache");
                _webviewController.clearCache();
              },
              onPageFinished: (String page) async {
                setState(() {
                  //_isPageLoaded = true;
                });
              },
              initialUrl: widget.url),
        ),
    );
  }

  @override
  Widget buildBK(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      //initialUrl: 'https://kidzee.com/PrivacyPolicy',
    );
  }
}

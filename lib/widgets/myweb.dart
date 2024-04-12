import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:lottie/lottie.dart';

import '../core/theme/light_colors.dart';

class MyWebViewScreen extends StatefulWidget {
  String url;
  String title;
  MyWebViewScreen({super.key, required this.title, required this.url});

  @override
  MyWebsiteViewState createState() => MyWebsiteViewState();
}

class MyWebsiteViewState extends State<MyWebViewScreen> {
  WebViewController? _controller;
  final Completer<WebViewController> controller =
  Completer<WebViewController>();

  bool isUrlLoadingCompleted = true;
  double progress = 0;

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Download',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          print('Download method calles........');
          /*Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );*/
        });
  }

  @override
  void initState() {
    super.initState();
    print(widget.url);
    // Enable hybrid composition.
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Lottie.asset('assets/json/loader.json'),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /*InAppWebViewController? _webViewController;

  @override
  Widget build1(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
          Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url:Uri.parse('http://pentemind.com')),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                      allowFileAccessFromFileURLs: true,
                      cacheEnabled: true,
                      supportZoom: true,
                      useOnDownloadStart: true,
                    javaScriptEnabled: true
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onDownloadStartRequest: (controller,url) async {
                  print("onDownloadStart ${url}");
                  //Utility.downloadImage(url.toString(), url.suggestedFilename.toString());

                  print("onDownloadStart new Url  ${url.url.scheme} ");
                  print("onDownloadStart new Url  ${url.url.query} ");
                  */ /*final taskId = await FlutterDownloader.enqueue(
                    url: url.url.data?.uri.toString() as String,
                    savedDir: (await getTemporaryDirectory()).path,
                    showNotification: false, // show download progress in status bar (for Android)
                    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                    saveInPublicStorage: false,
                  );*/ /*

                  */ /*final taskId = await FlutterDownloader.enqueue(
                    url: 'https://s3.amazonaws.com/content.pentemind/SummerCamp_2023/FunActivities/MindTrottersPath1/MT_P1_Activity6.png',
                    savedDir: (await getTemporaryDirectory()).path,
                    showNotification: false, // show download progress in status bar (for Android)
                    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                    saveInPublicStorage: false,
                  );*/ /*

                },
              ))
        ]));
  }*/
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        WebViewController webViewController = await controller.future;
        if (await webViewController.canGoBack()) {
          webViewController.goBack();
        } else {
          Navigator.pop(context);
        }
      },
      child: MaterialApp(
        title: widget.title,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: widget.title == 'Parent Support Desk' ||
              widget.title == 'ZLLSaathi'
              ? null
              : AppBar(
            backgroundColor: kPrimaryLightColor,
            leadingWidth: 30,
            title: Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ), // You can add title here
            leading: Padding(
              padding: const EdgeInsets.all(0.0),
              child: IconButton(
                icon:
                const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () async {
                  WebViewController webViewController =
                  await controller.future;
                  if (await webViewController.canGoBack()) {
                    webViewController.goBack();
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ), //You can make this transparent
            elevation: 0.0, //No shadow
          ),
          body: Container(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                print('FLWEB webview created....');
                _controller = webViewController;
                controller.complete(webViewController);
                //_controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print('FLWEB- WebView is loading (onProgress : $progress%)');
                if (progress >= 100 && !isUrlLoadingCompleted) {
                  isUrlLoadingCompleted = true;
                  Navigator.of(context, rootNavigator: true).pop('dialog');

                  //Navigator.pop(context);
                }
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
              navigationDelegate: (NavigationRequest request) {
                print('FLWEB-allowing navigation to $request');
                if (request.url.startsWith('fb://profile')) {
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                isUrlLoadingCompleted = false;
                showLoaderDialog(context);
                print('FLWEB-Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('FLWEB-Page onPageFinished loading: $url');
              },
              onWebResourceError: (WebResourceError error) {
                print(error.toString());
                //print('======');
              },
              gestureNavigationEnabled: true,
              geolocationEnabled: true, // set geolocationEnable true or not
            ),
          ),
        ),
      ),
    );
  }
//  }
}

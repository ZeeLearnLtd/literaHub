import 'dart:async';
import 'dart:io';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:literahub/core/theme/light_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:webview_flutter_platform_interface/src/types/web_resource_error.dart' as webview_flutter_platform_interface;


class MyWebView extends StatefulWidget {
  String url;
  String title;
  MyWebView({super.key,required this.url, required this.title});

  @override
  WebViewStaticState createState() => WebViewStaticState();
}

class WebViewStaticState extends State<MyWebView> {

  bool isUrlLoadingCompleted = true;
  double progress = 0;

  final GlobalKey webViewKey = GlobalKey();

  // InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      mediaPlaybackRequiresUserGesture: false,
      allowFileAccess: true,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);

  // PullToRefreshController? pullToRefreshController;
  final urlController = TextEditingController();


  @override
  void initState() {
    super.initState();

  }


  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Lottie.asset('assets/json/kidzee_loader.json'),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

  InAppWebViewController? webViewController;

  PullToRefreshController? pullToRefreshController;
  String url = "";
 

@override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: widget.title.isEmpty || widget.title == 'Parent Support Desk' ||
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
                        Navigator.pop(context);
                      },
                    ),
                  ), 
                  
                  elevation: 0.0, //No shadow
                ),
      backgroundColor: Colors.white,
      body:InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                  key: webViewKey,
                  //initialSettings: settings,
                  pullToRefreshController: pullToRefreshController,
                  onConsoleMessage: (controller, consoleMessage) async {
                    print('Console message: ${consoleMessage.message}');
                    // Handle console messages here
                    if(consoleMessage.message.contains("dwd::")){
                      var urls = consoleMessage.message.split('::');
                      print(urls);
                      String url = Uri.decodeFull(urls[1].trim());
                      print('url is $url');
                      Directory? tempDir = Platform.isIOS ? await getApplicationDocumentsDirectory() : await getExternalStorageDirectory();
                        print('in path $tempDir');
                        //setState(() {});
                        print("onDownload $url\n ${tempDir!.path}");
                        
                        if(Platform.isIOS){
                          await launchUrl(Uri.parse(url));
                        }else{
                          print("Download URL  $url");
                            await FlutterDownloader.enqueue(
                                url: url,
                                fileName: urls[2].trim(), //================File Name
                                savedDir: tempDir.path,
                                showNotification: true,
                                timeout: 90000,

                                requiresStorageNotLow: true,
                                openFileFromNotification: true,
                                saveInPublicStorage: true,
                            );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('File Download started, please check your Notification drawar')),
                          );
                        }
                    }
                  },
                  onDownloadStartRequest: (controller, url) async {
                    print('in onDownloadStartRequest $url');
                    print('248 in lunch');
                    if(!url.url.toString().contains("blob")){
                      Directory? tempDir = Platform.isIOS ? await getApplicationDocumentsDirectory() : await getExternalStorageDirectory();
                        print('in path $tempDir');
                        //setState(() {});
                        print("onDownload ${url.url.toString()}\n ${tempDir!.path}");
                        
                        if(Platform.isIOS) {
                          await launchUrl(Uri.parse(url.url.toString()));
                        } else {
                          await FlutterDownloader.enqueue(
                            url: 'https://pdfapi.zeelearn.com/api/convert?ID=2&JsonData={"Type":"Parent","student_id":"2564574","teacher_id":"0","event_id":"6","program_id":"261926","pdftype":"P"}',
                            fileName: 'file.pdf', //================File Name
                            savedDir: tempDir.path,
                            showNotification: true,
                            requiresStorageNotLow: false,
                            openFileFromNotification: true,
                            saveInPublicStorage: true,
                        );
                        }
                    }      
                  },
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  
                  onLoadStart: (controller, url) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  /* onPermissionRequest: (controller, request) async {
                    return PermissionResponse(
                        resources: request.resources,
                        action: PermissionResponseAction.GRANT);
                  }, */
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;

                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunchUrl(uri)) {
                        // Launch the App
                        await launchUrl(
                          uri,
                        );
                        // and cancel the request
                        return NavigationActionPolicy.CANCEL;
                      }
                    }

                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    pullToRefreshController?.endRefreshing();
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  /* onReceivedError: (controller, request, error) {
                    pullToRefreshController?.endRefreshing();
                  }, */
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      pullToRefreshController?.endRefreshing();
                    }
                    setState(() {
                      this.progress = progress / 100;
                      urlController.text = url;
                    });
                  },
                  onUpdateVisitedHistory: (controller, url, androidIsReload) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  
                ) /* WebViewWidget(controller: _controller) */,
    );
  }

  Future<bool?> isFileExists(path,fileName)async{
    return await io.File('$path/$fileName').exists();
  }

  Future<String?> getFileName(path,fileName) async{
      String mFileName = fileName;
      int index=0;
      bool isFileSet =false;
      do{
        print('do filename :  $path/${index==0 ? fileName : '($index)$fileName'}');
        if(await io.File('$path/${index==0 ? fileName : '($index)$fileName'}').exists()){
        //if(await isFileExists(path,index==0 ? fileName : '($index)$fileName')){
            print('$index fileName 379 $mFileName');
        }else{
            mFileName = index==0 ? fileName : '($index)$fileName';
            print('in else $index fileName $mFileName');
            isFileSet = true;
            break;
        }
        index++;
      }while(isFileSet==true);
      return mFileName;
  }

  Future<String?> donloadFile(url,urls,tempDir) async{
    print('download Response started');
    if(kIsWeb){
        launchUrl(Uri.parse(url));
        return 'Download Starts';
    }else {
      return await FlutterDownloader.enqueue(
                                url: url,
                                fileName: urls[2].trim(), //================File Name
                                savedDir: tempDir.path,
                                showNotification: true,
                                timeout: 90000,

                                requiresStorageNotLow: true,
                                openFileFromNotification: true,
                                saveInPublicStorage: true,
                            );
    }
                            
  }
}

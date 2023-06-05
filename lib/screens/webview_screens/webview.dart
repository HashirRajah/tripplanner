import 'package:flutter/material.dart';
import 'package:tripplanner/shared/constants/theme_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  //
  final String url;
  //
  const WebViewScreen({super.key, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  //
  late WebViewController controller;
  late Uri urlLink;
  //
  @override
  void initState() {
    super.initState();
    //
    urlLink = Uri.parse(widget.url);
    //
    initController();
  }

  //
  void initController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(docTileColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            Uri navigationLink = Uri.parse(request.url);
            //
            if (navigationLink.authority != urlLink.authority) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(urlLink);
  }

  //
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return Future.value(false);
        }
        //
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: overlayStyle,
          centerTitle: true,
          title: Text(urlLink.authority),
        ),
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  final String initialUrl;
  final String title;
  const WebViewApp({Key? key, required this.initialUrl, required this.title})
      : super(key: key);
  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
            isLoading = true;
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}

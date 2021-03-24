import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Web View")),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.download_sharp),
          onPressed: () async {
            _webViewController.evaluateJavascript("exportHTML()");
          },
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) async {
            _webViewController = controller;
            var htmldata = await rootBundle.loadString("htmlfiles/pdf1.ejs");
            _webViewController.loadUrl(Uri.dataFromString(
              htmldata.toString(),
              mimeType: "text/ejs",
              encoding: Encoding.getByName("utf-8"),
            ).toString());
          },
        ),
      ),
    );
  }
}

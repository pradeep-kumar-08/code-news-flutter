import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticalView extends StatefulWidget {
  final String blogUrl;

  ArticalView({required this.blogUrl});

  @override
  State<ArticalView> createState() => _ArticalViewState();
}

class _ArticalViewState extends State<ArticalView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.loadRequest(Uri.parse(widget.blogUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News"),
            Text("With"),
            Text(
              "Flutter",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

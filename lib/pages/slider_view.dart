import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SliderView extends StatefulWidget {
  final String sliderdesurl;

  SliderView({required this.sliderdesurl});

  @override
  State<SliderView> createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController();
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.loadRequest(Uri.parse(widget.sliderdesurl));
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

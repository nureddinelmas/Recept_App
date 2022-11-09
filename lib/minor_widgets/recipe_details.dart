import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final LinkedHashMap<String, dynamic> recipe;
  const RecipeDetailsScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen>
    with TickerProviderStateMixin {
  var loadingPercentage = 0;

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.download_for_offline_outlined))
        ],
        elevation: 0,
        title: Text(widget.recipe['label'].toString()),
        backgroundColor: Colors.amber.shade600,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.recipe['url'],
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              loadingPercentage = 100;
            },
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              minHeight: 10,
              color: Colors.amber,
              semanticsLabel: "Loading...",
              semanticsValue: "${loadingPercentage / 100.0}",
              value: loadingPercentage / 100.0,
            )
        ],
      ),
    );
  }
}

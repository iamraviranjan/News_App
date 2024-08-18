import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {

  String blogUrl;
  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => ArticleViewState();
}

class ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(
      title:
          Text("Trending News ", style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0.0,
      ),
      body: Container(
        child: WebView(
          initialUrl:widget.blogUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),

    );
  }}


//   Slider Article views.

class SliderArticleView extends StatefulWidget {

  String blogUrl;
  SliderArticleView({required this.blogUrl});

  @override
  State<SliderArticleView> createState() => SliderArticleViewState();
}

class SliderArticleViewState extends State<SliderArticleView> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(
      title:
      Text("Breaking News ", style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.bold)),
      centerTitle: true,
      elevation: 0.0,

    ),

      body: Container(
        child: WebView(
          initialUrl:widget.blogUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),

    );

  }}

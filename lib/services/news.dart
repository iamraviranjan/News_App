// 3rd collumn

import 'dart:convert';

import '../models/article_model.dart';

import 'package:http/http.dart' as http;


class News{
  List<ArticleModel> news=[];

  Future<void> getNews()async{
    String url="https://newsapi.org/v2/everything?q=tesla&from=2024-07-17&sortBy=publishedAt&apiKey=af4f78b7f09d45c4947590a728e8ecb8";

  var response = await http.get(Uri.parse(url));

  var jsonData= jsonDecode(response.body);
  if(jsonData['status']=='ok'){
    jsonData["articles"].forEach((element){
      if(element["urlToImage"]!=null && element['description']!=null){
        ArticleModel articleModel= ArticleModel(
          title: element['title'],
          description: element['description'],
          url: element['url'],
          urlToImage: element['urlToImage'],
          content: element['content'],
          author: element['author'],
        );
        news.add(articleModel);
      }
    });

  }
  }
}


// Slider news data.


class SliderNews{
  List<SliderArticleModel> slidernews=[];
  Future<void> getSliderNews()async{
    String url="https://newsapi.org/v2/everything?q=tesla&from=2024-07-17&sortBy=publishedAt&apiKey=af4f78b7f09d45c4947590a728e8ecb8";

    var response = await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          SliderArticleModel sliderarticleModel= SliderArticleModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          slidernews.add(sliderarticleModel);
        }
      });

    }
  }
}


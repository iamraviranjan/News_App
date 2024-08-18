//Slider 2nd column
// import 'package:newsapp/models/slider_model.dart';
// List<SliderModel> getSliders(){
//   List<SliderModel> slider=[];
//   SliderModel  categoryModel= new SliderModel();
//
//   categoryModel.image="images/bussiness.jpg";
//   categoryModel.name="How to Authority of Slider";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();
//
//   categoryModel.image="images/entertainment.jpg";
//   categoryModel.name="How to Authority of Slider";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();
//
//   categoryModel.image="images/general.jpg";
//   categoryModel.name="How to Authority of Slider";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();
//
//   categoryModel.image="images/health.jpg";
//   categoryModel.name="How to Authority of Slider";
//   slider.add(categoryModel);
//   categoryModel = new SliderModel();
//
//
//   return slider;
// }

// 3rd collumn

import 'dart:convert';
import 'package:newsapp/models/slider_model.dart';
import 'package:http/http.dart' as http;

class Sliders{
  List<sliderModel> sliders = [];

  Future<void> getSlider()async{
    String url="https://newsapi.org/v2/everything?q=tesla&from=2024-07-17&sortBy=publishedAt&apiKey=af4f78b7f09d45c4947590a728e8ecb8";

    var response = await http.get(Uri.parse(url));

    var jsonData= jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          sliderModel slidermodel= sliderModel(
            title: element['title'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
            author: element['author'],
          );
          sliders.add(slidermodel);
        }
      });

    }
  }
}
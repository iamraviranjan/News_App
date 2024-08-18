import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/pages/all_news.dart';
import 'package:newsapp/pages/article_view.dart';
import 'package:newsapp/pages/category_news.dart';
import 'package:newsapp/services/data.dart';
import 'package:newsapp/services/news.dart';
import 'package:newsapp/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/category_model.dart';
import '../models/slider_model.dart';

class Home extends StatefulWidget {  @override
State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = [];
  List<sliderModel> sliders = [];
  List<ArticleModel> articles = [];
  List<SliderArticleModel> slidernews = [];
  bool _loading=true;

  int activeIndex = 0;

  @override
  void initState() {
    categories = getCategories();
    getSlider();
    getNews();
    getSliderNews();
    super.initState();
  }

  getNews()async{
    News newsclass= News();
    await newsclass.getNews();
    articles=newsclass.news;
    setState(() {
      _loading=false;
    });
  }
  getSliderNews()async{
    SliderNews slidernewsclass= SliderNews();
    await slidernewsclass.getSliderNews();
    slidernews = slidernewsclass.slidernews;
  }

  getSlider()async{
    Sliders slider= Sliders();
   await slider.getSlider();
   sliders = slider.sliders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(" News ", style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0.0,

        ),

      body: _loading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10.0),
                height: 70,

                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length, itemBuilder: (context, index) {
                  return CategoryTile(image: categories[index].image,
                    categoryName: categories[index].categoryName,);
                },),
              ),

              //   BREAKING NEWS

              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Breaking News", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18,)
                    ),
                    GestureDetector(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Breaking",)));
                    },
                        child: Text("view all",
                        style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 16))),
                  ],
                ),
              ),

              SizedBox(height: 20.0,),

              CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder: (context, index, realIndex) {
                    String? res = sliders[index].urlToImage;
                    String? res1 = sliders[index].title;
                    String? url = sliders[index].url;
                    return buildImage(res!, index, res1!,url!);
                  },
                  options: CarouselOptions(
                      height: 250,
                      // viewportFraction: 1,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      }

                  )),
              SizedBox(height: 30,),
              Center(child: buildIndicator()),

              //    TRENDING NEWS TEXT

              SizedBox(height: 30.0,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trendeng News", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),
                    GestureDetector(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Trendeng",)));
                    },
                        child: Text("view all", style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500,fontSize: 16))),
                  ],
                ),
              ),
              SizedBox(height: 15,),

              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length, itemBuilder: (context, index){
                  return BlogTile(
                      url: articles[index].url!,
                      desc: articles[index].description!,
                      imageUrl: articles[index].urlToImage!,
                      title: articles[index].title!);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildImage(String image, int index, String name, String url) =>
   GestureDetector(onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context)=> SliderArticleView(blogUrl: url)));
   },
     child: Container(
       margin: EdgeInsets.symmetric(horizontal: 5.0),
       child: Stack(
       children: [
       ClipRRect(
       borderRadius: BorderRadius.circular(6),
       child: CachedNetworkImage(
       height: 250,
       fit: BoxFit.cover, width: MediaQuery.of(context).size.width,
       imageUrl: image,
       )
       ),
       Container(
       height: 250,
       padding: EdgeInsets.only(left: 10.0),
       margin: EdgeInsets.only(top: 180.0),
       width: MediaQuery.of(context).size.width,
       decoration: BoxDecoration(color: Colors.black26,
       borderRadius: BorderRadius.only(
       bottomLeft: Radius.circular(10),
       bottomRight: Radius.circular(10))),
       child: Text(name,maxLines: 2, style: TextStyle(color: Colors.white,
       fontSize: 20,
       fontWeight: FontWeight.w500),),
       ),
       ],
       ),
       ),
   );


  Widget buildIndicator() =>
      AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: SlideEffect(dotWidth: 12, dotHeight: 12, activeDotColor: Colors.blue),
      );
}

//1 column

class CategoryTile extends StatelessWidget {
  final image, categoryName;
  CategoryTile({this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(name: categoryName.toString() )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                image,
                width: 120,
                height: 70, fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              height: 60,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black26,),
              child: Center(child: Text(categoryName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 12),)),
            )
          ],
        ),
      ),
    );
  }
}

// 3rd column

class BlogTile extends StatelessWidget {
  String imageUrl, title, desc, url;

  BlogTile({required this.desc, required this.imageUrl, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0, ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: ClipRRect(borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(imageUrl: imageUrl,width: 120,height: 110,fit: BoxFit.cover,)
                    ),
                  ),
                  SizedBox(width: 5.0,),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.6,
                        child: Text(title,
                            maxLines: 2,
                            style: TextStyle(color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                      ),

                      SizedBox(height: 5.0,),

                      Container(
                        width: MediaQuery.of(context).size.width/1.6,
                        child: Text(desc,
                            maxLines: 3,
                            style: TextStyle(color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 15)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


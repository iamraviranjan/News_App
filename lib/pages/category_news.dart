import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/show_category.dart';
import 'package:newsapp/pages/article_view.dart';

import '../services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  String name;
   CategoryNews({required this.name});
  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}
class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
bool  _loading= true;

@override
  void initState() {
    super.initState();
    getNews();
  }

  getNews()async{
    ShowCategoryNews showCategoryNews= ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading= false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
        Text(widget.name, style: TextStyle(
        color: Colors.blue, fontWeight: FontWeight.bold)),
    centerTitle: true,
    elevation: 0.0,
      ),

      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: categories.length,
            itemBuilder: (context, index){
              return ShowCategory(
                  Image: categories[index].urlToImage!,
                  desc: categories[index].description!,
                  title: categories[index].title!,
                  url: categories[index].url!,
              );
            },
        ),

      ),
    );
  }
}


class ShowCategory extends StatelessWidget {
  String Image, desc, title, url;
  ShowCategory({required this.Image, required this.desc, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: Image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(title, maxLines: 2, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),),
            Text(desc, maxLines : 3,style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}

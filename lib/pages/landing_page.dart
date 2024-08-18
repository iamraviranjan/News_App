import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/home.dart';

class LandingPage extends StatefulWidget {  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .onSecondary,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        child: Column(
          children: [
            Material(
              elevation: 3.0,
              borderRadius: BorderRadius.circular(30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("images/hom.jpg",
                width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/1.7,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Text("News from around the \n        world for you", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26.0),),
            SizedBox(height: 20,),
            Text("Best time to read Take your time to read\n               a litle more of this world", style: TextStyle(color: Colors.black45,fontWeight: FontWeight.w500,fontSize: 18.0),),
            SizedBox(height: 50,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width/1.2,
                child: Material(
                    borderRadius: BorderRadius.circular(20),
                  elevation: 5.0,
                  child: Container(

                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                    child: Center(child: Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w500),)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }}

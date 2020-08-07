

import 'package:carousel_pro/carousel_pro.dart';
import 'package:demo/ui/Guestscreen/guesthomepage.dart';

import 'package:demo/ui/Home.dart';
import 'package:demo/ui/Ofscreens/reservedpage.dart';
import 'package:demo/ui/Usscreens/registercomplaint.dart';
import 'package:demo/ui/Usscreens/settings.dart';
import 'package:demo/util/auth.dart';
import 'package:demo/view/newslist.dart';
import 'package:demo/view/newsmis.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class userdashboard extends StatefulWidget {
  @override
  _userdashstate createState() => _userdashstate();
}

class _userdashstate extends State<userdashboard> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    
    Material MyItems(IconData icon,String heading,int color,Object jkn) {
      return Material(
    

        color: Colors.white,
        elevation: 14.0,
        shadowColor: Color(0X802196F3),
        borderRadius: BorderRadius.circular(24.0),
         child:InkWell(
            onTap:(){
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => jkn)
            );
            
            },
            child:Row(
             mainAxisAlignment :MainAxisAlignment.center,

             children: <Widget>[
             Column(
               mainAxisAlignment :MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(heading,
                    style:TextStyle(color: Color(color),
                    fontSize: 20.0
                    )
                    ),
                  ),
                  
                  Material(
                    color: Color(color),
                    child: Padding(padding: const EdgeInsets.all(8.0),
                    child: Icon(icon,
                    color:Colors.white,
                    size:30.0
                    ),
                    
                    )
                    ,
                  )



                ],
             )

           ],),
            ),

         
           );
            
            }
          
          
      
    
    

    
    Widget imageCarousel = new Container(
      height: 300.0,
      child:  new Carousel(
        boxFit: BoxFit.cover,
        images: [
           
          
        AssetImage('assets/WhatsApp1.jpg'),
        AssetImage('assets/images1.jpg',),
          AssetImage('assets/images6.jpg'),
          AssetImage('assets/WhatsApp2.jpg'),
          AssetImage('assets/bribery.jpg'),
         // AssetImage('assets/images2.jpg'),
        ],
        autoplay: true,
        dotBgColor: Colors.transparent,
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
      ),
    );
    return 
      Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        
        title: Text('Dashboard'),
        
    )
  
    ,body:
                 SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
   children:<Widget>[ 
     imageCarousel,
     
    
     SizedBox(
            height: 350.0,  
  child:StaggeredGridView.count(crossAxisCount: 2,
  crossAxisSpacing: 12.0,
  mainAxisSpacing: 12.0,
  padding: EdgeInsets.symmetric(horizontal:30.0,vertical:30.0),
  children: <Widget>[

MyItems(Icons.person,'Profile',0xffed622b,SettingsForm()),
MyItems(Icons.receipt,'File A Case',0xff26cb3c,addcomplaint()),
MyItems(Icons.pageview,'Newsfeed',0xff622F74,newsHome()),
MyItems(Icons.list,'Complaints',0xff7297ff,SettingsForm2()),
//MyItems(Icons.settings,SettingsForm2()),
//MyItems(Icons.settings,SettingsForm2())

  ],
  staggeredTiles: [
      StaggeredTile.extent(1,150.0 ),
       StaggeredTile.extent(1,150.0 ),
        StaggeredTile.extent(1,150.0 ),
         StaggeredTile.extent(1,150.0 ),


  ],
  
  
  
  
  )),
   Container(
     margin: const EdgeInsets.all(5.0),
    padding: const EdgeInsets.all(5.0),
  child:Center(
  child:FlatButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('Sign Out'),
                     onPressed: () async {
          dynamic result=await _auth.signOut();
           Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp())
            );
        },)
                    ),
                  )])
               
                ),
              
      );
    
  }
}
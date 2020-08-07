import 'package:demo/ui/Guestscreen/guesthomepage.dart';
import 'package:demo/ui/Ofscreens/ofsign_in.dart';


import 'package:demo/ui/Usscreens/sign_in.dart';
import 'package:demo/util/auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';




class MyApp extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage1(),
    );
  }
}
BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    color: Colors.transparent,
    border: Border.all(
      width: 2.0
    ),
    borderRadius: BorderRadius.all(
        Radius.circular(7.0) //                 <--- border radius here
    ),
  );
}
class LoginPage1 extends StatelessWidget {
  final AuthService _auth = AuthService();
  
  @override
  Widget build(BuildContext context) {
    Material MyItems(IconData icon,String heading,int color,Object jkn,bool f) {
      return Material(
    

        color: Colors.white,
        elevation: 14.0,
        shadowColor: Color(0X802196F3),
        borderRadius: BorderRadius.circular(24.0),
         child:InkWell(
            onTap:() async {
              if(!f){
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => jkn)
            );
              }
              else{
                dynamic result= await _auth.signInAnon();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addcomplaint2()
            ));
              }
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

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text('Home Page'),
      ),
      
      body:StaggeredGridView.count(crossAxisCount: 1,
  crossAxisSpacing: 12.0,
  mainAxisSpacing: 12.0,
  padding: EdgeInsets.symmetric(horizontal:30.0,vertical:30.0),
  children: <Widget>[

MyItems(Icons.person,'Officer',0xffed622b,SignInScreen2(),false),
MyItems(Icons.people,'User',0xff26cb3c,SignInScreen(),false),
MyItems(Icons.android,'Guest User',0xff622F74,addcomplaint2(),true),
//MyItems(Icons.list,'Complaints',0xff7297ff,SettingsForm2()),
//MyItems(Icons.settings,SettingsForm2()),
//MyItems(Icons.settings,SettingsForm2())

  ],
  staggeredTiles: [
      StaggeredTile.extent(1,200.0 ),
       StaggeredTile.extent(1,200.0 ),
        StaggeredTile.extent(1,200.0 ),
        // StaggeredTile.extent(1,150.0 ),


  ],
      
      
      
  
    ));}
}

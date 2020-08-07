
import 'package:demo/model/newsfeed.dart';
import 'package:demo/service/database.dart';
import 'package:demo/util/auth.dart';

import 'package:demo/view/newslist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class newsHome extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    

    return StreamProvider<List<news>>.value(
      value: DatabaseService().listnews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Newsfeed'),
          backgroundColor: Colors.brown[900],
          elevation: 0.0,
          
        ),
        body: Container(
         /* decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),*/
          child: newsList()
        ),
      ),
    );
  }
}
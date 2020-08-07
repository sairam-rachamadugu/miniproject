import 'package:demo/model/complaintlist.dart';
import 'package:demo/service/database.dart';
import 'package:demo/util/auth.dart';
import 'package:demo/view/c1list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class cmpHome extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    

    return StreamProvider<List<cmpl>>.value(
      value: DatabaseService().listcase,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Complaint List'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          
        ),
        body: Container(
         /* decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            ),
          ),*/
          child: cmList()
        ),
      ),
    );
  }
}
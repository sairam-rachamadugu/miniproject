import 'package:demo/model/complaintlist.dart';
//import 'package:demo/view/userlist.dart';
import 'package:demo/view/victimdetails.dart';
import 'package:flutter/material.dart';

class caseTile extends StatelessWidget {

  final cmpl cmpl1 ;
  caseTile({ this.cmpl1 });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            
            backgroundImage: AssetImage('assets/default.png'),
          ),
          title: Text(cmpl1.name),
          subtitle: Text('Taken Rs${cmpl1.money} as bribe'),
          onTap:(){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => culpritdetails(cmpl1:cmpl1))
            );},
          
        ),
      ),
    );
  }
}
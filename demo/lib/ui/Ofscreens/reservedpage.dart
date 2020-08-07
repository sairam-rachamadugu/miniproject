import 'package:demo/model/user.dart';
import 'package:demo/service/database.dart';

import 'package:demo/view/complaintview.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingsForm2 extends StatefulWidget {
  @override
  _SettingsForm2State createState() => _SettingsForm2State();
}

class _SettingsForm2State extends State<SettingsForm2> {

  final _formKey = GlobalKey<FormState>();
  

  // form values
 

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return 
    StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          if(snapshot.data.role=='officer'){
return cmpHome();
          }
          else{
           Fluttertoast.showToast(msg: 'You have no permission to access this contents ');
        }}
        else{
        //Navigator.pop(context);
         }
         return Center(
           child:Text('YOU ARE NOT AUTHORISED',
          
                        style: TextStyle(color: Colors.red, fontSize: 30
           ),
           ));
           
      }
      
    );
  }
}
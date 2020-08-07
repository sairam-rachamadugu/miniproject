
import 'package:demo/model/user.dart';

import 'package:demo/ui/Guestscreen/guesthomepage.dart';
import 'package:demo/ui/Home.dart';

import 'package:demo/ui/Usscreens/userdashboard.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);
    int i=0;
    if (user==null){
      return MyApp();
    }
    else{
      print('sairam   ;');
      print(user.uid);
      if(user.email==null){
        return addcomplaint2();
      }
      
return userdashboard();
           
          
      
      }
      
      
      }}


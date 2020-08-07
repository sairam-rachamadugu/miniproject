import 'package:demo/model/user.dart';

import 'package:demo/ui/wrapper.dart';

import 'package:demo/util/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




void main() => runApp(MyApp1());




  

class MyApp1 extends StatelessWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
          child: new
       MaterialApp(
         navigatorKey: navigatorKey,
        theme: new ThemeData(primarySwatch: Colors.blue),
       home: Wrapper(),
       
      
       ));
  }
}
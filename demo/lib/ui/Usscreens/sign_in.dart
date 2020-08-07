
import 'package:demo/main.dart';

import 'package:demo/ui/Usscreens/register.dart';
import 'package:demo/ui/widgets/loading.dart';

import 'package:demo/util/auth.dart';
import 'package:demo/util/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignInScreen extends StatefulWidget {
 

  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool s=false;
  bool loading=false;
  String error='';
  String email1='';
  String password1=''; 
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _scaffold = GlobalKey();


  bool _autoValidate = false;
  bool _loadingVisible = false;
  
  @override
  void initState() {
    super.initState();
  }
 @override
  Widget build(BuildContext context) {
    

  
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/default.png',
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
     TextFormField email;
try{
     email = TextFormField(
      
     
      autofocus: false,
      
      onChanged: (val) {
                  setState(() => email1 = val);
                },
      validator: Validator.validateEmail,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.email,
            color: Colors.grey,
          ), ),
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
   } catch(e){
    print('sairam     :');
print(e);
  }

    final password = TextFormField(
      
      autofocus: false,
      obscureText: true,
      onChanged: (val) {
                  setState(() => password1 = val);
                },
      validator: Validator.validatePassword,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 5.0),
          child: Icon(
            Icons.lock,
            color: Colors.grey,
          ), // icon is 48px widget.
        ), // icon is 48px widget.
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: (){_emailLogin(email: email1,password:password1,context:context,);
        // Navigator.pop(context)
            },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('SIGN IN', style: TextStyle(color: Colors.white)),
      ),
    );

    

  
    return loading?Loading():Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text('Sign In'),
         actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () { Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen())
            );},
          ),
        ],
  
      ),
      backgroundColor: Colors.white,
      body:  
             Form(
            key: _formKey,
          
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      logo,
                      SizedBox(height: 48.0),
                      email,
                      SizedBox(height: 24.0),
                      password,
                      SizedBox(height: 12.0),
                      loginButton,
                      SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
                     
                    ],
                  ),
                ),
              ),
            ),
          ),
    
    );
  
  
  }

  

  void _emailLogin(
      {String email, String password, BuildContext context,}) async {
        
        try{
          SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (_formKey.currentState.validate()) {
      setState(()=>loading=true);
     dynamic result=await _auth.signin(email.trim(), password.trim());
         if(result == null) {
           s=true;
                      setState(() {
                        loading=false;
                        Fluttertoast.showToast(msg: 'Please supply a valid details or check internet connection')
                         ;
                      });}}
    else{
      s=true;
    }}
    catch(e){
      error = e;
    }
    if (!s){
       await Navigator.push(context,MaterialPageRoute(builder: (context) => MyApp1())); }}

}
import 'package:demo/model/user.dart';
import 'package:demo/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  

  // form values
  String _currentName;
  String _currentlast;
  String _currentpassword;
  String _currentadhaar;
  String _currentphone;
  bool loading=false;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
         
  
      ),
      backgroundColor: Colors.white,
      body:Container(
     margin: const EdgeInsets.all(5.0),
    padding: const EdgeInsets.all(5.0),
    child:StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: _formKey,
            child:SingleChildScrollView(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                child:Text(
                  'Update your profile settings.',
                  style: TextStyle(fontSize: 18.0,color: Colors.red),
                ),),
                //SizedBox(height: 10.0),
                Divider(),
                
              Text('Email',style: TextStyle(color:Colors.brown),),
              Divider(),
               Text(snapshot.data.email,style: TextStyle(fontSize: 18.0)),
               Divider(),
               Text('Password',style: TextStyle(color:Colors.brown),),
                SizedBox(height: 5.0),
                TextFormField(
                  initialValue: userData.password,
                
                  validator: (val) => val.isEmpty ? 'Please enter password' : null,
                  onChanged: (val) => setState(() => _currentpassword = val),
                ),
                Divider(),
                              Text('First Name',style: TextStyle(color:Colors.brown),),

                SizedBox(height: 5.0),

                TextFormField(
                  initialValue: userData.firstName,
                
                  validator: (val) => val.isEmpty ? 'Please enter first name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                Divider(),
                              Text('Last Name',style: TextStyle(color:Colors.brown),),

                SizedBox(height: 5.0),
                TextFormField(
                  initialValue: userData.lastName,
                
                  validator: (val) => val.isEmpty ? 'Please enter last name' : null,
                  onChanged: (val) => setState(() => _currentlast = val),
                ),
                Divider(),
                              Text('Phone Number',style: TextStyle(color:Colors.brown),),

                SizedBox(height: 5.0),
               TextFormField(
                  initialValue: userData.phoneNumber.toString(),
                
                  validator: (val) => val.isEmpty||val.length!=10 ? 'Please enter phone number correctly' : null,
                  onChanged: (val) => setState(() {
                    _currentphone=val;
                  }),
                ),
                Divider(),
                              Text('Adhaar Number',style: TextStyle(color:Colors.brown),),

                SizedBox(height: 5.0),
                TextFormField(
                  initialValue: userData.adhaar.toString(),
                
                  validator: (val) => val.isEmpty||val.length!=12 ? 'Please enter adhaar Number' : null,
                  onChanged: (val) => setState(() => _currentadhaar = val),
                ),
                Divider(),
                              Text('Role',style: TextStyle(color:Colors.brown),),

               Divider(),
                Text(snapshot.data.role,style: TextStyle(fontSize: 18.0),),
                
                Divider(),
                Center(
                child:RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    setState(() {
                        loading=true;
                         Fluttertoast.showToast(msg: 'Profile Updated');
                      });
                    if(_formKey.currentState.validate()){

                      await DatabaseService(uid: user.uid).updateUserData(
                        snapshot.data.email, 
                        _currentpassword ?? snapshot.data.password, 
                        _currentName ?? snapshot.data.firstName, 
                        _currentlast ?? snapshot.data.lastName, 
                        (_currentphone) ?? snapshot.data.phoneNumber,
                        (_currentadhaar)??snapshot.data.adhaar
                        ,snapshot.data.role
                      );
                      
                      setState(() {
                        loading=false;
                         Fluttertoast.showToast(msg: 'Profile Updated');
                      });
                  
                      //Navigator.pop(context);
                    }
                    
                  }
                ),)
              ],
            ),
          ));
        } 
        else{
          return Text('Check ur internet connection');
        }
      }
    )));
  }
}
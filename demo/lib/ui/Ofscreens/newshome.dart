import 'dart:io';

import 'package:demo/model/complaintlist.dart';
import 'package:demo/service/complaintdb.dart';
import 'package:demo/service/newsfeeddb.dart';
import 'package:demo/ui/Home.dart';
import 'package:demo/ui/widgets/loading.dart';
import 'package:demo/util/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';


class newshome extends StatefulWidget {
  
  
  @override
  _newshomeState createState() => _newshomeState( );
}

class _newshomeState extends State<newshome> {
   
  final AuthService _auth = AuthService();
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  String id='';
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController money = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  newsfeeddb complaint=newsfeeddb();
  complaintdb cmp=complaintdb();
      bool loading=false;
      
  File _image1;
  bool _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = false;
  }


  @override
  Widget build(BuildContext context) {
    
        return loading
                  ? Loading()
                  : Scaffold(
          appBar: AppBar(
            //elevation: 1,
            backgroundColor: red,
            
            title: Text(
              "Uploading Page",
              style: TextStyle(color: black),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              //child:Text('faehfakjl'),
              child: Column(
                      children: <Widget>[
                        Text('**Add Proofs',style: TextStyle(color: Colors.black, fontSize: 18.0),),
                        
                          
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: OutlineButton(
                                    borderSide: BorderSide(
                                        color: grey.withOpacity(0.5), width: 2.5),
                                    onPressed: () {
                                      _selectImage(
                                          ImagePicker.pickImage(
                                              source: ImageSource.gallery),
                                          1);
                                    },
                                    child: _displayChild1()),
                              ),
                            
                            
                          
                        
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '*Enter the accused name',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 15),
                          ),
                        ),
    
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: name,
                            decoration: InputDecoration(hintText: 'Name'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'You must enter the accused name';
                              } else if (value.length > 20) {
                                return 'Name cant have more than 20 letters';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '*Enter the incident place',
                            
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 15),
                          ),
                        ),
    
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: location,
                            decoration: InputDecoration(hintText: 'Location'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'You must enter the Location';
                              } 
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '*Enter crime details',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 15),
                          ),
                        ),
    
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            keyboardType:TextInputType.multiline,
                              maxLines: null,
                            controller: details,
                            decoration: InputDecoration(hintText: 'Details'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'You must enter the crime details';
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '*Money involved(Approximately)',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: black, fontSize: 15),
                          ),
                        ),
    
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            controller: money,
                            decoration: InputDecoration(hintText: 'Money'),
                            
                            
                          ),
                        ),
                        FlatButton(
                          color: red,
                          textColor: white,
                          child: Text('Submit'),
                          onPressed: () {
                            validateAndUpload();
                            
                            }
                          
                        ),
                         FlatButton(
                          color: red,
                          textColor: white,
                          child: Text('Finish'),
                          onPressed: () {
                            
                            if(_isButtonDisabled){
                            Navigator.pop(context,true);}
                          
                          else{
                            Fluttertoast.showToast(msg: 'first upload');

                          }}
                        ),
                                
                  ]))));}
   void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        break;
     
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  
  Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
  void validateAndUpload() async {
    //dynamic result= await _auth.signInAnon();
    if (_formKey.currentState.validate()) {
      if(_image1!=null){
      setState(() => loading = true);
      

        
          String imageUrl1;
         

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_image1);
          
          

          

          task1.onComplete.then((snapshot1) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            
            String imageList = imageUrl1;

            complaint.uploadcomplaint({
              "name":name.text,
              "amount":double.parse(money.text),
              "location":location.text,
              "images":imageList,
              
              "details":details.text,
            });
             

           
            setState(() { loading = false;
             
                 _isButtonDisabled = true;

            Fluttertoast.showToast(msg: 'NewsFeed added');
            //Navigator.pop(context);
            });
          });
          
      }
      else{
        setState(() { loading = false;
             
              _isButtonDisabled=true;

            Fluttertoast.showToast(msg: ' Image must be added');});
      } 
     
    
    }}

  


}
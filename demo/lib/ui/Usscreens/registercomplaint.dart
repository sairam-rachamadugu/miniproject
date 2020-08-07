import 'dart:io';

import 'package:demo/service/complaintdb.dart';
import 'package:demo/ui/Home.dart';
import 'package:demo/ui/widgets/loading.dart';
import 'package:demo/util/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';


class addcomplaint extends StatefulWidget {
  @override
  _addcomplaintState createState() => _addcomplaintState();
}

class _addcomplaintState extends State<addcomplaint> {
  final AuthService _auth = AuthService();
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  TextEditingController name = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController details = TextEditingController();
  TextEditingController money = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  complaintdb complaint=complaintdb();
      bool loading=false;
  File _image1;
  File _image2;
  File _image3;


  @override
  Widget build(BuildContext context) {
    return loading
              ? Loading()
              : Scaffold(
      appBar: AppBar(
        //elevation: 1,
        backgroundColor: red,
        
        title: Text(
          "Register complaint",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          //child:Text('faehfakjl'),
          child: Column(
                  children: <Widget>[
                    Text('Add Proofs',style: TextStyle(color: Colors.black, fontSize: 18.0),),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
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
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                                borderSide: BorderSide(
                                    color: grey.withOpacity(0.5), width: 2.5),
                                onPressed: () {
                                  _selectImage(
                                      ImagePicker.pickImage(
                                          source: ImageSource.gallery),
                                      2);
                                },
                                child: _displayChild2()),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: grey.withOpacity(0.5), width: 2.5),
                              onPressed: () {
                                _selectImage(
                                    ImagePicker.pickImage(
                                        source: ImageSource.gallery),
                                    3);
                              },
                              child: _displayChild3(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '*Enter the accused Name',
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
                          } else if (value.length > 30) {
                            return 'Name cant have more than 30 letters';
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
                      },
                    ),
                     


                      
                    
                  ]))));}
   void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        break;
      case 2:
        setState(() => _image2 = tempImg);
        break;
      case 3:
        setState(() => _image3 = tempImg);
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

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image3,
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
    
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      if(_image1==null){
        File f = await getImageFileFromAssets('default.png');
        _image1=f;
      }
       if(_image2==null){
        File f = await getImageFileFromAssets('default.png');
        _image2=f;
      }
       if(_image3==null){
        File f = await getImageFileFromAssets('default.png');
        _image3=f;
      }
        
          String imageUrl1;
          String imageUrl2;
          String imageUrl3;

          final FirebaseStorage storage = FirebaseStorage.instance;
          final String picture1 =
              "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task1 =
              storage.ref().child(picture1).putFile(_image1);
          final String picture2 =
              "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task2 =
              storage.ref().child(picture2).putFile(_image2);
          final String picture3 =
              "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
          StorageUploadTask task3 =
              storage.ref().child(picture3).putFile(_image3);

          StorageTaskSnapshot snapshot1 =
              await task1.onComplete.then((snapshot) => snapshot);
          StorageTaskSnapshot snapshot2 =
              await task2.onComplete.then((snapshot) => snapshot);

          task3.onComplete.then((snapshot3) async {
            imageUrl1 = await snapshot1.ref.getDownloadURL();
            imageUrl2 = await snapshot2.ref.getDownloadURL();
            imageUrl3 = await snapshot3.ref.getDownloadURL();
            List<String> imageList = [imageUrl1, imageUrl2, imageUrl3];

            complaint.uploadcomplaint({
              "name":name.text,
              "amount":double.parse(money.text),
              "location":location.text,
              "images":imageList,
              
              "details":details.text,
            });
            setState(() {
               loading = false;
            Fluttertoast.showToast(msg: 'Complaint added');
            });
          });
          
      } 
     
    
    }
  


}
import 'package:demo/model/complaintlist.dart';
import 'package:demo/service/complaintdb.dart';
import 'package:demo/ui/Ofscreens/newshome.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class culpritdetails extends StatelessWidget {
  cmpl cmpl1 ;
  complaintdb cm;
  bool s=false;
   culpritdetails({cmpl cmpl1}){
    this.cmpl1=cmpl1;
    this.cm=complaintdb();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        title: Text('CULPRIT DETAILS'),
      ),
      
      body:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              
                child: SingleChildScrollView(
    
  child:
  Center(
    child:Column(
    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
    Container(
     margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(30.0),
        //decoration: myBoxDecoration(),
         child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
          
           children:<Widget>[
             Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ACCUSED DETAILS',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: 28),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                     child:
                     Row(
                       children:<Widget>[
                         Expanded(child:
                       Text( 'NAME',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.brown, fontSize: 15),
                      ))
                      ,
                      Expanded(
                       child: Text( cmpl1.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))]
                     )
                      
                    )
                    , Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Row(
                       children:<Widget>[
                         Expanded(
                        child:Text( 'INCIDENT PLACE',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.brown, fontSize: 15),
                      )),
                      Expanded(
                        child:Text( cmpl1.location,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))]
                      )
                      
                    ),
                     Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:Row(
                       children:<Widget>[
                         Expanded(
                        child:Text( 'AMOUNT',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.brown, fontSize: 15),
                      )),
                      Expanded(
                        child:Text( 'Rs${cmpl1.money}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ))]
                      )
                      
                    )
                   ,
                   Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text( 'CRIME DETAILS',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.brown, fontSize: 15),
                      )),
                      Padding(
                      padding: const EdgeInsets.all(8.0),
                      
                        child:Text( '${cmpl1.details}',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      )
                      )
                      
                
                   ,Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Click on below links for Images',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network('${cmpl1.imageList[0]}')
                    ),
             Padding(
padding: const EdgeInsets.all(8.0),
             child:InkWell(
              child: new Text('1st Image',textAlign: TextAlign.center,style: TextStyle(decoration:TextDecoration.underline,color:Colors.black,fontSize:25),),
              onTap: () => launch('${cmpl1.imageList[1]}')
          ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),

             child:InkWell(
              child: new Text('2nd Image',textAlign: TextAlign.center,style: TextStyle(decoration:TextDecoration.underline,color:Colors.black,fontSize:25),),
              onTap: () => launch('${cmpl1.imageList[2]}')
          ),

          ),
          
           
           ]
         )),
         Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: ()  async {
         // DatabaseService().getrole().document[0]
         s=await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => newshome())
            );
           // print(s);
             },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('Upload to newsfeed', style: TextStyle(color: Colors.white)),
      ),
    ),
     Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: ()  {
         // DatabaseService().getrole().document[0]
         if (s!=null && s!=false){
           cm.remove1(cmpl1.id);
          Fluttertoast.showToast(msg: 'removed');}
          else{
            Fluttertoast.showToast(msg: 'First u should upload to newsfeed');
          }

          
             },
        padding: EdgeInsets.all(12),
        color: Theme.of(context).primaryColor,
        child: Text('Remove Complaint', style: TextStyle(color: Colors.white)),
      ),
    ),
         ]
         )))));
    
  }
}

import 'package:demo/model/newsfeed.dart';
import 'package:flutter/material.dart';
class newstile extends StatelessWidget {
final news cmpl1 ;
  newstile({ this.cmpl1 });
 @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
        child: Column(
          children:<Widget>[
            Padding(
                      padding: const EdgeInsets.all(4.0),
                      child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children :<Widget>[
              new RichText(
  text: TextSpan(
    
    style: DefaultTextStyle.of(context).style,
    children: <TextSpan>[
      TextSpan(text: 'NAME - ', style: TextStyle(color: Colors.brown, fontSize: 18)),
      TextSpan(text: '${cmpl1.name}',style:TextStyle(color: Colors.black, fontSize: 18)),
    ],
  ),
) ,
new RichText(
  text: TextSpan(
    
    style: DefaultTextStyle.of(context).style,
    children: <TextSpan>[
      TextSpan(text: 'MONEY - ', style: TextStyle(color: Colors.brown, fontSize: 18)),
      TextSpan(text: '${cmpl1.money}',style:TextStyle(color: Colors.black, fontSize: 18)),
    ],
  ),
) ,
                    ]
            ))
            
            ,
            SizedBox(height:10.0),
            new Image.network('${cmpl1.imageList}',fit:BoxFit.cover),
           
            new RichText(
  text: TextSpan(
    
    style: DefaultTextStyle.of(context).style,
    children: <TextSpan>[
      TextSpan(text: 'LOCATION - ', style: TextStyle(color: Colors.brown, fontSize: 18)),
      TextSpan(text: '${cmpl1.location}',style:TextStyle(color: Colors.black, fontSize: 18)),
    ],
  ),
  textAlign:TextAlign.center,
) ,
            new Text(' DESCRIPTION  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.brown, fontSize: 17),

                  ),
                   new Text('${cmpl1.details}',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  ),] )),);}}
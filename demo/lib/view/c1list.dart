import 'package:demo/model/complaintlist.dart';
import 'package:demo/view/caseTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class cmList extends StatefulWidget {
  @override
  _cmListState createState() => _cmListState();
}

class _cmListState extends State<cmList> {
  @override
  Widget build(BuildContext context) {

    final listcase = Provider.of<List<cmpl>>(context) ?? [];

    return ListView.builder(
      itemCount: listcase.length,
      itemBuilder: (context, index) {
        return caseTile(cmpl1: listcase[index]);
      },
    );
  }
}
/*print(listcase.length);*/

  
        /*  TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15.0),
              hintText: 'Filter by name or email',
            ),
            onChanged: (string) {
              
                setState(() {
                  
                  listcase = filteredUsers
                      .where((u) => (u.name
                              .toLowerCase()
                              .contains(string.toLowerCase()) ||
                          u.location.toLowerCase().contains(string.toLowerCase())))
                      .toList();
                      print("");
                }
                );
              
            },
          
           
    );*/
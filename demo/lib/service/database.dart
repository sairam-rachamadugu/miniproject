
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/model/complaintlist.dart';
import 'package:demo/model/newsfeed.dart';
import 'package:demo/model/user.dart';

class DatabaseService{
 // Firestore _firestore = Firestore.instance;
  final String uid;
  DatabaseService({this.uid});
    final CollectionReference bribCollection = Firestore.instance.collection('case');
    final CollectionReference bribCollection1 = Firestore.instance.collection('newsfeed');

  final CollectionReference briberyCollection = Firestore.instance.collection('info');
  Future<void> updateUserData(String email,String password,String firstname,String lastname,String phoneNumber,String adhaar,String role) async {
    return await briberyCollection.document(uid).setData({
      
      'firstName': firstname.trim(),
              'lastName': lastname.trim(),
              'email': email.trim(),
              'password': password.trim(),
              'phoneNumber':phoneNumber,
              'adhaar':adhaar,
              'role':role,
      
    });
   
   
  }

 List<cmpl> _cmplListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return cmpl(
        name: doc.data['name'] ?? '',
        location: doc.data['location'] ?? '',
        details: doc.data['details'] ?? '',
        money: doc.data['amount']??'',
        imageList: doc.data['images'],
        id: doc.data['id']

      );
    }).toList();
  }  
   Stream<List<cmpl>> get listcase {
    return bribCollection.snapshots()
      .map(_cmplListFromSnapshot);
  }
  List<news> _cmplListFromSnapshot1(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return news(
        name: doc.data['name'] ?? '',
        location: doc.data['location'] ?? '',
        details: doc.data['details'] ?? '',
        money: doc.data['amount']??'',
        imageList: doc.data['images'],

      );
    }).toList();
  }  
   Stream<List<news>> get listnews {
    return bribCollection1.snapshots()
      .map(_cmplListFromSnapshot1);
  }
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
      phoneNumber: snapshot.data['phoneNumber'],
      password: snapshot.data['password'],
      adhaar: snapshot.data['adhaar'],
      email: snapshot.data['email'],
      role: snapshot.data['role'],

    );
  }
  Stream<UserData> get userData {
    return briberyCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}


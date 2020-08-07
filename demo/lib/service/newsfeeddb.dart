import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class newsfeeddb {
  Firestore _firestore = Firestore.instance;
  String ref = 'newsfeed';

  void uploadcomplaint(Map<String, dynamic> data) {
    var id = Uuid();
    String caseId = id.v1();
    data["id"] = caseId;
    _firestore.collection(ref).document(caseId).setData(data);
  }
  
}
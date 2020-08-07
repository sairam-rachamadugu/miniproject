import 'package:demo/model/user.dart';
import 'package:demo/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
User _userFromFirebaseUser(FirebaseUser user){
  return user!= null? User(uid:user.uid,email: user.email):null;
}
Stream<User> get user{
return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
}

  // sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
Future signin(String email,String password) async{
    try{
      print(email);
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user= result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e);
    }
  }

  // register with email and password
  Future registeration(String email,String password,String firstname,String lastname,String phoneNumber,String adhaar,String role) async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      FirebaseUser user= result.user;
      await DatabaseService(uid: user.uid).updateUserData(email,password,firstname,lastname,phoneNumber,adhaar,role);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e);
    }
  }

  // sign out
  Future signOut() async{
    try{
    return await _auth.signOut();
    }
    catch(e){
      return null;
    } 
  }
static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this email address not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'This email address already has an account.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }
}
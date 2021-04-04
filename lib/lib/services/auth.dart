import 'package:pineapple_demo3/model/user.dart';
import 'package:pineapple_demo3/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  
  final FirebaseAuth _auth = FirebaseAuth.instance;


  String get getuserid {
    return _auth.currentUser.uid;
  }

  //create user object based on User
  UserData _userFromUser(User user){
    if(user != null){
      return UserData(userid: user.uid);
    }else{
      return null;
    }
  }

  // auth change user stream
  Stream<UserData> get user{
    return _auth.authStateChanges().map((User user) => _userFromUser(user));
  }



  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String name, String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(userid: user.uid).updateUserData(name);
      return _userFromUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
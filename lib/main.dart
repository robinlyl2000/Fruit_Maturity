import 'package:pineapple_demo1/model/user.dart';
import 'package:pineapple_demo1/pages/allcomments/allcommentpage.dart';
import 'package:pineapple_demo1/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:pineapple_demo1/pages/selfcomments/selfcommentpage.dart';
import 'package:pineapple_demo1/pages/upload/upload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pineapple_demo1/pages/wrapper.dart';
import 'package:pineapple_demo1/services/auth.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value: AuthService().user,
      child : MaterialApp(
        home: Wrapper(),
        routes: <String, WidgetBuilder> {
          '/wrapper' : (BuildContext context) => Wrapper(),
          '/home' : (BuildContext context) => Home(),
          '/upload': (BuildContext context) => Upload(),
          '/selfpage' : (BuildContext context) => SelfCommentPage(),
          '/allpage' : (BuildContext context) => AllCommentPage(),
        },
      ),
    );
  }
}
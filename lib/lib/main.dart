import 'package:pineapple_demo3/model/user.dart';
import 'package:pineapple_demo3/pages/comments/commenthome.dart';
import 'package:pineapple_demo3/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:pineapple_demo3/pages/price/pricehome.dart';
import 'package:pineapple_demo3/pages/upload/upload.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pineapple_demo3/pages/wrapper.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
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
          '/commentpage' : (BuildContext context) => CommentHome(),
          '/pricepage' : (BuildContext context) => PriceHome(),
        },
      ),
    );
  }
}
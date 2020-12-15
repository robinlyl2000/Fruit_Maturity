import 'package:flutter/material.dart';
import 'package:pineapple_demo1/pages/home.dart';

void main() async{
  runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    },
  ));
}

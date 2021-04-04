import 'package:pineapple_demo3/model/user.dart';
import 'package:pineapple_demo3/pages/authenticate/authenticate.dart';
import 'package:pineapple_demo3/pages/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserData>(context);

    //return either Home or Authenticate Widget
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
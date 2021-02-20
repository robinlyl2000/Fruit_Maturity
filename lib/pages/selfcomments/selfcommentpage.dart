import 'package:flutter/material.dart';
import 'package:pineapple_demo1/model/imageSaving.dart';
import 'package:pineapple_demo1/services/auth.dart';
import 'package:pineapple_demo1/pages/selfcomments/image_list.dart';
import 'package:pineapple_demo1/services/database.dart';
import 'package:provider/provider.dart';

final AuthService _auth = AuthService();
final String userid = _auth.getuserid;

class SelfCommentPage extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Imagesaving>>.value(
      value: DatabaseService(userid: userid).selfimages,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('您的紀錄'),
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                  color: Colors.white,
                ),
              label: Text(
                '登出',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
          body: Container(
            child: ImageList(userid: userid),
          )
      ),
    );
  }
}
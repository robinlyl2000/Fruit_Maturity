import 'package:flutter/material.dart';
import 'package:pineapple_demo1/model/imageSaving.dart';
import 'package:pineapple_demo1/services/auth.dart';
import 'package:pineapple_demo1/pages/allcomments/image_list.dart';
import 'package:pineapple_demo1/services/database.dart';
import 'package:provider/provider.dart';

final AuthService _auth = AuthService();
final String userid = _auth.getuserid;

class AllCommentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _showFilter(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.amber, 
        );
      });
    }

    return StreamProvider<List<Imagesaving>>.value(
      value: DatabaseService(userid: userid).allimages,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('所有用戶紀錄'),
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
        body: Column(
          children: [
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[900]),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  icon: Icon(
                    Icons.sort,
                    size: 18,
                    color: Colors.grey[900],
                  ),
                  onPressed: ((){
                    _showFilter();
                  }),
                  label: Text(
                    '篩選條件',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                    ),  
                  ),
                  color: Colors.grey[200],
                ),
            ),
            Expanded(
              child: ImageList(userid: userid),
            ),
          ],
        ),
      ),
    );
  }
}
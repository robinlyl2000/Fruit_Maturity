import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:pineapple_demo3/pages/comments/allcomments/image_list.dart';
import 'package:pineapple_demo3/services/database.dart';
import 'package:pineapple_demo3/services/filter.dart';
import 'package:provider/provider.dart';

final AuthService _auth = AuthService();
final String userid = _auth.getuserid;

class AllCommentPage extends StatefulWidget {
  @override
  _AllCommentPageState createState() => _AllCommentPageState();
}

class _AllCommentPageState extends State<AllCommentPage> {
  
  String status = '由舊到新';
  int start = 0;
  int end = 6;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _showFilter(){
      showModalBottomSheet(context: context,builder: (context){
        return Container(
          height: 200,
          color: Colors.white, 
          alignment: Alignment.center,
          child : FilterPage(status : status),
        );
      }).then((value){
        setState(() {
          status = value.selection;
          start = value.start;
          end = value.end;
        });
      });
    }

    return StreamProvider<List<Imagesaving>>.value(
      value: DatabaseService(userid: userid).allimages(status, start, end),
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
                Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
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
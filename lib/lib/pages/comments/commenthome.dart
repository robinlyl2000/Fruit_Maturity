import 'package:flutter/material.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:pineapple_demo3/services/filter.dart';
import 'package:provider/provider.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/services/database.dart';
import 'package:pineapple_demo3/pages/comments/image_list.dart';

final AuthService _auth = AuthService();
final String userid = _auth.getuserid;

class CommentHome extends StatefulWidget {
  @override
  _CommentHomeState createState() => _CommentHomeState();
}

class _CommentHomeState extends State<CommentHome> {
  String status = '由舊到新';
  int start = 0;
  int end = 6;
  bool _isselfpage = true;

  @override
  Widget build(BuildContext context) {

    void _showFilter(){
      showModalBottomSheet(context: context,builder: (context){
        return Container(
          height: 350,
          color: Color(0xff9aa153),
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

    return Scaffold(
      backgroundColor: Color(0xffefcd62),
      appBar: AppBar(
        backgroundColor: Color(0xff9aa153),
        title: _isselfpage ? Text('你的紀錄') : Text('所有用戶紀錄'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.white,
              size: 33,
            ),
            onPressed: () async {
              await _auth.signOut();
            }
          )
        ],
      ),
      body: StreamProvider<List<Imagesaving>>.value(
        value: _isselfpage ? DatabaseService(userid: userid).selfimages(status, start, end) : DatabaseService(userid: userid).allimages(status, start, end),
        child: Padding(
          padding: EdgeInsets.only(bottom: 70),
          child: Column(
            children: [
              Container(
                height: 40,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
                child: FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff804e1c)
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    icon: Icon(
                      Icons.sort,
                      size: 18,
                      color: Color(0xff804e1c),
                    ),
                    onPressed: ((){
                      _showFilter();
                    }),
                    label: Text(
                      '篩選條件',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff804e1c),
                      ),  
                    ),
                    color: Color(0xffe3ae3d),
                  ),
              ),
              Expanded(
                child: ImageList(userid: userid, pagestate: _isselfpage),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 80,
            color: Color(0xff9aa153),
          ),
          Container(
            height: 10,
            color: Color(0xffefcd62),
          ),
          Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(flex: 2),
                    FlatButton(
                      onPressed: (){
                        setState(() {
                          _isselfpage = true;
                          status = '由舊到新';
                          start = 0;
                          end = 6;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.assignment_ind_rounded,
                            size: 30,
                          ),
                          Text('你的紀錄')
                        ],
                      )
                    ),
                    Spacer(flex: 10),
                    FlatButton(
                      onPressed: (){
                        setState(() {
                          _isselfpage = false;
                          status = '由舊到新';
                          start = 0;
                          end = 6;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.view_module_rounded,
                            size: 30,
                          ),
                          Text('所有用戶紀錄')
                        ],
                      )
                    ),
                    Spacer(flex: 1),
                  ],
                ),
              ],
            ),
          ),
          Image.asset(
            'assets/test.png',
            fit: BoxFit.fitHeight,
            height: 80,
          ),
          Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 19),
                IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 45,
                  onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil('/upload', ModalRoute.withName('/home'));
                  }
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
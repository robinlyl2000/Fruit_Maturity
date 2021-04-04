import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/pages/upload/commet.dart';
import 'package:pineapple_demo3/services/database.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:intl/intl.dart';
import 'package:pineapple_demo3/model/suggest.dart';
import 'dart:math';

final AuthService _auth = AuthService();

class ShowResult extends StatefulWidget {

  final Imagesaving save;
  ShowResult({this.save});

  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  double rate; 
  String suggest;
  String id =  _auth.getuserid;

  String _getsuggest(double ratio){
    if(ratio <= 35){
      int randomNumber = Random().nextInt(3);
      List t = suggest_list['生鳳梨'];
      //return t[randomNumber];
      return t[2];
    }else if(ratio > 35 && ratio <= 70){
      return suggest_list['熟鳳梨'];
    }else if(ratio > 70){
      return suggest_list['過熟鳳梨'];
    }
    return null;
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      suggest = _getsuggest(widget.save.ratio);
      rate = widget.save.ratio ?? 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    
    return Scaffold(
      backgroundColor: Color(0xffefcd62),
      appBar: AppBar(
        title: Text('辨識結果'),
        centerTitle: true,
        backgroundColor: Color(0xff9aa153),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 33,
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
          }
        ),
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
      body: Padding(
        padding: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2),
            SizedBox(
                width: 300,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        height: 200,
                        width: 180,
                        color: Color(0xffaa9964),
                        child: Image.file(
                          widget.save.file,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(
                            '上傳者 :',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            '${widget.save.username}',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '熟度 :',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            '${widget.save.ratio.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '上傳日期 :',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ]
                      ),
                    )
                  ],
                ),
              ),
            Spacer(flex: 3),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                height: 45,
                color: Color(0xff9aa153),
                child: Text(
                  '熟度 : ${rate.toStringAsFixed(2)}%',
                  textAlign : TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ), 
                ),
              ),
            ),
            Spacer(flex: 3),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: Color(0xff9aa153),
                height: 170,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  suggest,
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
              ),
            ),
            Spacer(flex: 2),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FlatButton(
                      color: Color(0xffdd4341),
                      onPressed: (){
                        Navigator.of(context).pushNamedAndRemoveUntil('/selfpage', ModalRoute.withName('/home'));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.grid_view,
                            color: Color(0xff4d5b5a),
                          ),
                          Text(
                            '上傳紀錄',
                            style: TextStyle(
                              color: Color(0xff4d5b5a),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FlatButton(
                      color: Color(0xff4d5b5a),
                      onPressed: () async {
                        widget.save.comment = '(尚無評論)';
                        widget.save.username = await DatabaseService().getusername(widget.save.userid);
                        widget.save.likenum = 0;
                        await DatabaseService(userid : widget.save.userid).updateImageData(widget.save, true);
                        Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: Color(0xffe4af3d),
                          ),
                          Text(
                            '回到首頁',
                            style: TextStyle(
                              color: Color(0xffe4af3d),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FlatButton(
                      color: Color(0xffe4af3d),
                      onPressed: () async{
                        widget.save.username = await DatabaseService().getusername(widget.save.userid);
                        Navigator.push(context,MaterialPageRoute(
                          builder: (context) => CommentPage(save : widget.save)
                        ));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.comment_rounded,
                            color: Color(0xff4b5553),
                          ),
                          Text(
                            '新增評論',
                            style: TextStyle(
                              color: Color(0xff4b5553),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: Color(0xff9aa153),
      ),
    );
  }
}
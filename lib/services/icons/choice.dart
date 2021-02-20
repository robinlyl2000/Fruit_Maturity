import 'package:flutter/material.dart';
import 'package:pineapple_demo1/model/imageSaving.dart';
import 'package:pineapple_demo1/services/icons/edit.dart';
import 'package:pineapple_demo1/services/database.dart';


class Choice extends StatefulWidget {
  final String sendid;
  final Imagesaving save;
  Choice({this.sendid, this.save});
  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {

    Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('確認刪除此圖片?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('確定'),
              onPressed: () async{
                await DatabaseService(userid : widget.save.userid, imageID: widget.save.imageID).deleteImageData();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  
  Widget build(BuildContext context) {
    if(widget.sendid == widget.save.userid){
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              iconSize: 25,
              icon: Icon(Icons.create),
              onPressed: (){
                Navigator.push(context,MaterialPageRoute(
                  builder: (context) => EditPage(save: widget.save)
                ));
              },
            )
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              iconSize: 25,
              icon: Icon(Icons.clear),
              onPressed: (){
                _showMyDialog();
              },
            )
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              iconSize: 25,
              icon: Icon(Icons.share),
              onPressed: () async{
                
              },
            )
          ),
        ]
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : <Widget>[
          Expanded(
            flex: 1,
            child: IconButton(
              iconSize: 25,
              icon: Icon(Icons.share),
              onPressed: (){},
            )
          ),
        ]
      );
    }
  }
}
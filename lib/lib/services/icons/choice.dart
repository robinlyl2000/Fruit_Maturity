import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/services/icons/edit.dart';
import 'package:pineapple_demo3/services/database.dart';


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
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.create,
                      size: 22,
                    ),
                    SizedBox(height: 1),
                    Text(
                      '編輯紀錄',
                      style: TextStyle(
                        fontSize: 12
                      ),
                    )
                  ],
                ),
                color: Color(0xffdd4341),
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(
                    builder: (context) => EditPage(save: widget.save)
                  ));
                },
              ),
            ),
          ),
          Spacer(flex: 1),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.clear,
                      size: 22,
                    ),
                    SizedBox(height: 1),
                    Text(
                      '刪除紀錄',
                      style: TextStyle(
                        fontSize: 12
                      ),
                    )
                  ],
                ),
                color: Color(0xffdd4341),
                onPressed: (){
                  _showMyDialog();
                },
              ),
            ),
          ),
          Spacer(flex: 1),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                      size: 22,
                    ),
                    SizedBox(height: 1),
                    Text(
                      '分享紀錄',
                      style: TextStyle(
                        fontSize: 12
                      ),
                    )
                  ],
                ),
                color: Color(0xffdd4341),
                onPressed: (){
                  
                },
              ),
            ),
          ),
        ]
      );
    }else{
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 80,
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                      size: 22,
                    ),
                    SizedBox(height: 1),
                    Text(
                      '分享紀錄',
                      style: TextStyle(
                        fontSize: 12
                      ),
                    )
                  ],
                ),
                color: Color(0xffdd4341),
                onPressed: (){
                  _showMyDialog();
                },
              ),
            ),
          ),
        ]
      );
    }
  }
}
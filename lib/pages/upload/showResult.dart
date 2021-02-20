import 'package:flutter/material.dart';
import 'package:pineapple_demo1/model/imageSaving.dart';
import 'package:pineapple_demo1/pages/upload/commet.dart';
import 'package:pineapple_demo1/services/database.dart';

Imagesaving save = new Imagesaving();

class ShowResult extends StatefulWidget {

  ShowResult(Imagesaving input){
    save = input;
  }

  @override
  _ShowResultState createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  String rate = '0.0';
  @override
  void initState() {
    super.initState();
    setState(() {
      rate = save.ratio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 400,
              child: Image.file(save.file),
            ),
            SizedBox(height: 20),
            Text(
              '熟度 : $rate%',
              textAlign : TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.grey[700],
              ), 
            ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () async{
                      save.comment = '(尚無評論)';
                      save.username = await DatabaseService().getusername(save.userid);
                      await DatabaseService(userid : save.userid).updateImageData(save);
                      Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
                    },
                    color: Colors.grey[700], 
                    child: Text(
                      '回到主頁',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),  
                    ),
                  ),
                  SizedBox(width: 15),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(
                        builder: (context) => CommentPage(save)
                      ));
                    },
                    color: Colors.grey[700], 
                    child: Text(
                      '新增評論',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),  
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
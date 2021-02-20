import 'package:flutter/material.dart';
import 'package:pineapple_demo1/model/imageSaving.dart';
import 'package:pineapple_demo1/services/database.dart';

Imagesaving save = Imagesaving();

class CommentPage extends StatefulWidget {
  
  CommentPage(Imagesaving input){
    save = input;
  }

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  String _currentComment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
          },
        ),
        title: Text(' 新增評論'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                child: Image.file(save.file),
              ),
              SizedBox(height: 20),
              Text(
                '熟度 : ${save.ratio}%',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[700],
                ), 
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 200,
                child: TextFormField(
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: null,
                    maxLines: null, 
                    expands: true, 
                  decoration:InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 2.0) 
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0) 
                    ),
                  ),
                  validator: (val) {
                    if(val.isEmpty){
                      return '評論不得空白';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      _currentComment = val;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () async{
                  save.comment = _currentComment;
                  save.username = await DatabaseService().getusername(save.userid);
                  await DatabaseService(userid : save.userid).updateImageData(save);
                  Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
                },
                color: Colors.grey[700], 
                child: Text(
                  '確定',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),  
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
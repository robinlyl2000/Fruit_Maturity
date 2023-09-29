import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:pineapple_demo3/pages/upload/showResult.dart';
import 'package:pineapple_demo3/services/loading.dart';

class UploadFlask extends StatefulWidget {

  final Imagesaving save;
  UploadFlask({this.save});

  @override
  _UploadFlaskState createState() => _UploadFlaskState();
}

class _UploadFlaskState extends State<UploadFlask> {
  bool _isReady = false;
  bool _isFail = true;

  //send request to server
  Future<void> _upload() async {
    try{
      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(widget.save.path,  filename: widget.save.filename ?? 'pineapple.jpg'),
      });  

      // set timer in 30 secs
      Timer(Duration(seconds: 30), (){
        if(_isFail == true){
          showAlertDialog(context);
        }
      });
      
      Dio dio = new Dio(); 
      Response response = await dio.post("https://pineapple.jeff3071.repl.co/upload", data: formData);
      Map list = json.decode(response.data);
      print(list['maturity_percent']);
      widget.save.ratio = list['maturity_percent'];
      print(list['url']);
      widget.save.url = list['url'];
      _isReady = true;
      _isFail = false;
      Navigator.push(context,MaterialPageRoute(
        builder: (context) => ShowResult(save : widget.save)
      ));
    }catch(e){
      print('error: $e');
      showAlertDialog(context);
    }
  }

  void showAlertDialog(BuildContext context){
    showDialog(
      barrierColor: Colors.grey[900],
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 1.0,
          title: Text(
            '上傳失敗',
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '原因 : 連接伺服器過久',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  onPressed: ((){
                    Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
                  }),
                  child : Text(
                    '回首頁',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),  
                  ),
                  color: Colors.grey[700],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.grey[100],
        );
      }
    );
  }
  

  @override
  void initState() {
    super.initState();
    // upload image
    _upload();
  }

  @override
  Widget build(BuildContext context) {
    if(_isReady == false){
      return Loading();
    }else{
      return Container(color: Colors.green);
    }
  }
}

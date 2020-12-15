import 'package:pineapple_demo1/classes/image.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Home()
  ));
}

Imagesaving save = new Imagesaving();

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fruit Maturity'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
      ),
      body: Center(
        child: Homecontainer(),
      ),
    );
  }
}

class Homecontainer extends StatefulWidget {
  const Homecontainer({
    Key key,
  }) : super(key: key);

  @override
  _HomecontainerState createState() => _HomecontainerState();
}

class _HomecontainerState extends State<Homecontainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 20.0),
          child: Image(
            image: AssetImage('assets/pineapple.jpg'),
          ),
        ),
        Button()
      ],
    );
  }
}

class Button extends StatefulWidget {
  @override
  _ButtonState createState() => _ButtonState();
}


class _ButtonState extends State<Button> {
  String muturiryShow = '請上傳圖片';
  String content;
  String path;

  // use image picker
  Future<void> getImage() async {
    final picker = ImagePicker(); 
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    await _upload(File(pickedFile.path));
  }
  
  //send request to server
  Future<void> _upload(File file) async {
    try{
      save.file = file;
      save.path = file.path;
      Dio dio = new Dio();  
      FormData formData = new FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path,  filename: "pineapple.jpg"),
      });
      Response response = await dio.post("http://10.0.2.2:5000/upload", data: formData);
      save.ratio = json.decode(response.data);
    }catch(e){
      print('error: $e');
    }
  }

  //get information of image, and show its ratio
  void _showratio() async{
    await getImage();
    print('Ratio: ${save.ratio}');
    setState(() {
      muturiryShow = '成熟度為${double.parse((save.ratio).toStringAsFixed(2))}%';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(
                Icons.cloud_upload,
                color: Colors.grey[700],
              ),
              onPressed: () {
                setState(() {
                  _showratio();
                });
              },
              label: Text('Send'),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.replay,
                color: Colors.grey[700],
              ),
              onPressed: () {
                setState(() {
                  muturiryShow = '請上傳圖片';
                });
              },
              label: Text('Reset'),
            ),
          ],
        ),
        SizedBox(height: 30.0),
        Text(
          '$muturiryShow',
          style: TextStyle(
            fontSize: 30.0
          ),
        ),
      ],
    );
  }
}
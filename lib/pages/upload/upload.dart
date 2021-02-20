import 'package:flutter/material.dart';
import 'package:pineapple_demo1/model/imageSaving.dart';
import 'package:pineapple_demo1/pages/upload/camera.dart';
import 'package:pineapple_demo1/pages/upload/gallery.dart';
import 'package:pineapple_demo1/services/auth.dart';

final AuthService _auth = AuthService();

class Upload extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新增照片'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 30.0),
              child: Image(
                image: AssetImage('assets/background.png'),
              ),
            ),
            Buttons(),
          ],
        ),
      ),
    );
  }
}



class Buttons extends StatefulWidget {
  const Buttons({Key key,}) : super(key: key);

  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {

  
  String id =  _auth.getuserid;
  Imagesaving save = Imagesaving();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          icon: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
          onPressed: (() {
            save.userid = id;
            Navigator.push(context,MaterialPageRoute(
              builder: (context) => CameraPage(save)
            ));
          }),
          label: Text(
            '拍攝照片',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),  
          ),
          color: Colors.grey[700],
        ),
        FlatButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          icon: Icon(
            Icons.publish,
            color: Colors.white,
          ),
          onPressed: ((){
            save.userid = id;
            Navigator.push(context,MaterialPageRoute(
              builder: (context) => GalleryPage(save)
            ));
          }),
          label: Text(
            '上傳照片',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),  
          ),
          color: Colors.grey[700],
        ),
      ],
    );
  }
}
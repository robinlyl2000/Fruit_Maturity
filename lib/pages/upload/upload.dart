import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/pages/upload/camera.dart';
import 'package:pineapple_demo3/pages/upload/gallery.dart';
import 'package:pineapple_demo3/services/auth.dart';

final AuthService _auth = AuthService();

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  
  String id =  _auth.getuserid;
  Imagesaving save = Imagesaving();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefcd62),
      appBar: AppBar(
        title: Text('新增照片'),
        centerTitle: true,
        backgroundColor: Color(0xff9aa153),
        elevation: 0.0,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: Image(
                image: AssetImage('assets/background.png'),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: SizedBox(
                width: double.infinity,
                height: 43,
                child: FlatButton.icon(
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
                  color: Color(0xff5d5f2c),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: SizedBox(
                width: double.infinity,
                height: 43,
                child: FlatButton.icon(
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
                  color: Color(0xff5d5f2c),
                ),
              ),
            ),
            Spacer(flex: 2)
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
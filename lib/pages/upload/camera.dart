import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'dart:io';
import 'package:pineapple_demo3/services/database.dart';
import 'package:pineapple_demo3/services/uploadFlask.dart';

Imagesaving save = Imagesaving();

class CameraPage extends StatefulWidget {

  CameraPage(Imagesaving input){
    save = input;
  }

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  List<CameraDescription> _cameras;
  CameraController _controller;
  bool _isReady = false;
  File file;

  @override
  void initState() {
    super.initState();
    _setUpCamera();
  }

  void _setUpCamera() async {
    try {
      _cameras = await availableCameras();
      _controller = CameraController(_cameras[0],ResolutionPreset.medium);
      await _controller.initialize();
    }catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: getFooter(),
      body: getBody(),
    );
  }

  Widget cameraPreview() {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: CameraPreview(_controller)
    );
  }

  Widget getBody() {
    
    // return loading widget
    if (_isReady == false || _controller == null || !_controller.value.isInitialized) {
      return Container(
        color: Colors.white,
      );
    }
    // camera widget
    var size = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(height: 70),
        Transform.scale(
          scale: 1.0,
          child: AspectRatio(
            aspectRatio: 3.0 / 4.0,
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  width: size,
                  height: size / _controller.value.aspectRatio,
                  child: cameraPreview()
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 70),
      ],
    );
  }

  // camera control widget
  Widget getFooter() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 70),
          Center(
            child: Transform.scale(
              scale: 1.3,
              child: Image.asset(
                'assets/pineapple.png',
                fit: BoxFit.fitHeight,
                color: Colors.yellow,
              )
            )
          ),
          Container(
            height: 70,
            child: RawMaterialButton(
              onPressed: () async{
                await _controller.takePicture().then((XFile e){
                  save.path = e.path;
                  save.file = File(save.path);
                  save.filename = e.name;
                });
                save.username = await DatabaseService().getusername(save.userid);
                await Navigator.push(context,MaterialPageRoute(
                  builder: (context) => UploadFlask(save: save)
                ));
              },
              elevation: 2.0,
              child: Icon(
                Icons.camera,
                color: Colors.white,
                size: 35.0,
              ),
              padding: EdgeInsets.all(15.0),
              shape: CircleBorder(
                side: BorderSide(color: Colors.white, width: 2)
              ),
            )
          ),
        ],
      )
    );
  }
}
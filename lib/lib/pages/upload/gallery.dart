import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/services/loading.dart';
import 'package:pineapple_demo3/services/uploadFlask.dart';
import 'dart:io';
import 'package:pineapple_demo3/services/database.dart';

Imagesaving save = Imagesaving();

class GalleryPage extends StatefulWidget {

  GalleryPage(Imagesaving input){
    save = input;
  }

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  bool _isReady = false;

  //get information of image, and show its ratio
  Future<void> _imagepicker() async{
    try{
      final picker = ImagePicker(); 
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if(pickedFile == null){
        Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
      }
      _isReady = true;
      save.path = pickedFile.path;
      save.file = File(save.path);
      save.username = await DatabaseService().getusername(save.userid);
      Navigator.push(context,MaterialPageRoute(
        builder: (context) => UploadFlask(save: save)
      ));
    }catch(e){
      print(e.toString());
      Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    _imagepicker();
  }

  @override
  Widget build(BuildContext context) {
    if(_isReady == false){
      return Loading();
    }else{
      return Container();
    }
  }
}


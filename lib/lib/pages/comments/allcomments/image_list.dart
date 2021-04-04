import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:flutter/material.dart';
import 'package:pineapple_demo3/pages/comments/allcomments/image_tile.dart';
import 'package:provider/provider.dart';

class ImageList extends StatefulWidget {
  final String userid;
  ImageList({this.userid});
  @override
  _ImageListState createState() => _ImageListState();
}

class _ImageListState extends State<ImageList> {
  @override
  Widget build(BuildContext context) {
    final images = Provider.of<List<Imagesaving>>(context) ?? [];
    return Scrollbar(
    child: ListView.builder(
        itemCount: images.length,
        itemExtent: 120.0,
        itemBuilder: (context, index){
          return ImageTile(save: images[index],userid: widget.userid);
        },
      ),
    );
    
  }
}
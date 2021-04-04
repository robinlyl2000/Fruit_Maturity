import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:flutter/material.dart';
import 'package:pineapple_demo3/pages/comments/image_tile.dart';
import 'package:provider/provider.dart';
import 'package:pineapple_demo3/pages/comments/detail.dart';

class ImageList extends StatefulWidget {
  final String userid;
  final bool pagestate; //true for selfpage, false for allpage
  ImageList({this.userid, this.pagestate});
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
        itemBuilder: (context, index){
          return InkWell(
            child: ImageTile(save: images[index],userid: widget.userid),
            onTap: (){
              showDialog(context: context, builder: (ctx) => DetailPage(save: images[index]));
            },
          );
        },
      ),
    );
  }
}
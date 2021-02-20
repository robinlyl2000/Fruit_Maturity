import 'package:flutter/material.dart';
import 'package:pineapple_demo1/model/imageSaving.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pineapple_demo1/services/icons/choice.dart';



class ImageTile extends StatefulWidget {
  
  final Imagesaving save;
  final String userid;
  ImageTile({this.save, this.userid});

  @override
  _ImageTileState createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
    
      color: Colors.grey[300],
      margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.save.url),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                color: Colors.grey[200],
              ),
            ),
          ),
          Spacer(flex: 2),
          Expanded(
            flex: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LinearPercentIndicator(
                  trailing: Text(
                    '  ${widget.save.getlevel()}級',
                    style: TextStyle(fontSize: 18),
                  ),
                  lineHeight: 30.0,
                  percent: double.parse(widget.save.ratio)/100,
                  animation: true,
                  center: Text(
                    '${double.parse(widget.save.ratio)}%',
                    style: TextStyle(fontSize: 16),
                  ),
                  animationDuration: 1000,
                  backgroundColor: Colors.grey[400],
                  progressColor: Color(widget.save.getcolor()),
                ),
                Text(
                  '${widget.save.comment}',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                Text(
                  '${widget.save.time}',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
              ],
            ),
          ),
          Spacer(flex: 1),
          Expanded(flex:4, child: Choice(sendid: widget.userid, save: widget.save)),
        ],
      ),
    );
  }
}

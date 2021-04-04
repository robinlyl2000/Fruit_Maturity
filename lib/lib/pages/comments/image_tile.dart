import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/services/database.dart';

class ImageTile extends StatefulWidget {
  
  final Imagesaving save;
  final String userid;
  ImageTile({this.save, this.userid});

  @override
  _ImageTileState createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {

  int num;
  bool _islike;

  @override
  void initState() {
    super.initState();
    num = widget.save.likenum;
    DatabaseService(userid: widget.userid).checkLikeImage(widget.save).then((value){
      setState(() {
        _islike = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: 120,
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: Color(0xffe3ae3d),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 100,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    color: Color(0xffa48a52),
                  ),
                  child: Image.network(
                    widget.save.url,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 220,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 10,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 10,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '【${widget.save.tag}】',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  color: Color(0xffbebd3b),
                                ),
                              ),
                            ),
                            Spacer(flex: 2),
                            Flexible(
                              flex: 10,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  '${widget.save.getlevel()}級',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  color: Color(0xffbe752a),
                                ),
                              ),
                            ),
                            Spacer(flex: 2),
                            Flexible(
                              flex: 10,
                              child: InkWell(
                                onTap: ()async{
                                  if(_islike == true){
                                    await DatabaseService(userid: widget.userid).deleteLikeImage(widget.save);
                                  }else{
                                    await DatabaseService(userid: widget.userid).updateLikeImage(widget.save);
                                  }
                                  setState(() {
                                    if(_islike == true){
                                      num--;
                                    }else{
                                      num++;
                                    }
                                    _islike = !_islike;
                                  });
                                  widget.save.likenum = num;
                                  await DatabaseService(userid: widget.userid, imageID: widget.save.imageID).updateImageData(widget.save, false);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(width: 10),
                                      Icon(
                                        _islike == false ? Icons.favorite_border : Icons.favorite,
                                        color: _islike == false ? Colors.black : Colors.red,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Flexible(
                                        child: Text(
                                          widget.save.likenum.toString(),
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    color: Color(0xff9aa153),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(flex: 2),
                      Flexible(
                        flex: 10,
                        child: Container(
                          width: 220,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            color: Color(0xff4b5553),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.save.comment,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

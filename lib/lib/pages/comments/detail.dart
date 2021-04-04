import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:pineapple_demo3/services/icons/choice.dart';

final AuthService _auth = AuthService();
final userid = _auth.getuserid;

class DetailPage extends StatefulWidget {
  final Imagesaving save;
  DetailPage({this.save});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 500,
        width: 310,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 8,
            color: Color(0xff9aa153),
          ),
          color: Color(0xffbebd3b),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Flexible(
              flex: 12,
              child: Row(
                children: [
                  Flexible(
                    flex: 40,
                    child: Container(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                            widget.save.url,
                            fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 5),
                  Flexible(
                    flex: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              color: Colors.black,
                              alignment: Alignment.center,
                              child: Text(
                                '上傳者',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            widget.save.username,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                          )
                        ),
                        Spacer(flex: 1),
                        Flexible(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.0),
                            child: Container(
                              color: Colors.black,
                              alignment: Alignment.center,
                              child: Text(
                                '上傳時間',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            )
                          ),
                        ),
                        Flexible(
                          flex: 5,
                          child: Text(
                            widget.save.gettime(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                            ),
                          )
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
            Spacer(flex: 2),
            Flexible(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  width: 150,
                  child: Text(
                    '熟度',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )
              ),
            ),
            Spacer(flex: 1),
            Flexible(
              flex: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: LinearPercentIndicator(
                  lineHeight: 30.0,
                  percent: widget.save.ratio/100,
                  animation: true,
                  center: Text(
                    '${widget.save.ratio.toStringAsFixed(2)}%',
                    style: TextStyle(fontSize: 16),
                  ),
                  animationDuration: 1000,
                  backgroundColor: Colors.grey[400],
                  progressColor: Color(widget.save.getcolor()),
                ),
              ),
            ),
            Spacer(flex: 2),
            Flexible(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  width: 150,
                  child: Text(
                    '評論',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      decoration: TextDecoration.none,
                    ),
                  ),
                )
              ),
            ),
            Spacer(flex: 1),
            Flexible(
              flex: 10,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xff5A8F86),
                ),
                padding: EdgeInsets.all(10),
                child: Text(
                  widget.save.comment,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  ),
                ),
              )
            ),
            Spacer(flex: 2),
            Flexible(
              flex: 8,
              child: Choice(save: widget.save, sendid: userid),
            )
          ]
        ),
      ),
    );
  }
}
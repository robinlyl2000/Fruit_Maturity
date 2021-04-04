import 'package:flutter/material.dart';
import 'package:pineapple_demo3/pages/price/form.dart';
import 'package:pineapple_demo3/pages/price/linechart.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

final AuthService _auth = AuthService();

class PriceHome extends StatefulWidget {
  @override
  _PriceHomeState createState() => _PriceHomeState();
}

class _PriceHomeState extends State<PriceHome> {

  bool _isready = false;
  bool _mainchart = true;
  Map list;
  Future<void> _getdata() async {
    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);
    try{
      Dio dio = new Dio(); 
      Response response = await dio.get("https://pineapple.jeff3071.repl.co/getprice/$date");
      list = json.decode(response.data);
      setState(() {
        _isready = true;
      });
    }catch(e){
      print('error: '+ e.toString());
    }
  }

  Widget _showpage(){
    if(_isready){
      if(_mainchart){
        return FormPage(list: list);
      }else{
        return LineChartPage(list: list);
      }
    }else{
      return Container(
        child: Text('Loading'),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefcd62),
      appBar: AppBar(
        backgroundColor: Color(0xff9aa153),
        title: _mainchart ? Text('時價列表') : Text('各市場時價分析'),
        centerTitle: true,
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
      body: _showpage(),
      bottomSheet:  Container(
        height: 70,
        color: Color(0xff9aa153),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(flex: 2),
                FlatButton(
                  onPressed: (){
                    setState(() {
                      _mainchart = true;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.assignment_ind_rounded,
                        size: 30,
                      ),
                      Text('時價列表')
                    ],
                  )
                ),
                Spacer(flex: 5),
                FlatButton(
                  onPressed: (){
                    setState(() {
                      _mainchart = false;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.timeline_rounded,
                        size: 30,
                      ),
                      Text('各市場時價分析')
                    ],
                  )
                ),
                Spacer(flex: 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
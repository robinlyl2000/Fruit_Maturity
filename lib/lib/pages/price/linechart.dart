import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class LineChartPage extends StatefulWidget {
  final Map list;
  
  LineChartPage({this.list});
  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {

  double minY, maxY;
  List<LineChartBarData> lines = [];
  final List detail = [
    ['台北市', Color(0xff2b99c6), false],
    ['台北一', Color(0xffafb040), false],
    ['台北二', Color(0xff980240), false],
    ['板橋區', Color(0xff817c15), false],
    ['三重區', Color(0xff424bc5), false],
    ['宜蘭市', Color(0xff3f9e18), false],
    ['桃農', Color(0xffca9a05), false],
    ['台中市', Color(0xff090b1d), false],
    ['豐原區', Color(0xff35f7c0), false],
    ['東勢區', Color(0xff4bbb62), false],
    ['南投市', Color(0xffed4d19), false],
    ['嘉義市', Color(0xff67ac8f), false],
    ['高雄市', Color(0xff1d2f0d), false],
    ['鳳山區', Color(0xff3c7f08), false],
    ['台東市', Color(0xff8f2fea), false]
  ];
  
  void _setlines(Map input){
    
    final DateTime now = DateTime.now();
    final day1 = DateFormat('yyy.MM.dd').format(DateTime(now.year - 1911, now.month, now.day-3));
    final day2 = DateFormat('yyy.MM.dd').format(DateTime(now.year - 1911, now.month, now.day-2));
    final day3 = DateFormat('yyy.MM.dd').format(DateTime(now.year - 1911, now.month, now.day-1));
    final day4 = DateFormat('yyy.MM.dd').format(DateTime(now.year - 1911, now.month, now.day));
    for(int i = 0; i < input.length; i++){
      double tempmin = 100;
      double tempmax = 0;
      final location = input.keys.elementAt(i);
      //get price
      List<double> price = [-1, -1, -1, -1];
      for(var x in input[location]){
        if(x['TransDate']== day1){
          price[0] = x['Avg_Price'];
        }else if(x['TransDate'] == day2){
          price[1] = x['Avg_Price'];
        }else if(x['TransDate'] == day3){
          price[2] = x['Avg_Price'];
        }else if(x['TransDate'] == day4){
          price[3] = x['Avg_Price'];
        }
      }

      // set minY
      price.forEach((e){
        if(e <= tempmin && e != -1){
          tempmin = e;
        }else if(e >= tempmax){
          tempmax = e;
        }
      });
      setState(() {
        minY = tempmin - 6;
        maxY = tempmax + 6;
      });

      // set color
      Color color;
      detail.forEach((e) {
        //e[2] = true;
        if(e[0] == location){
          color = e[1];
          e[2] = true;
        }
      });

      //set lines
      lines.add(
        LineChartBarData(
          spots: [
            FlSpot(0, price[0] == -1 ? null : price[0]),
            FlSpot(1, price[1] == -1 ? null : price[1]),
            FlSpot(2, price[2] == -1 ? null : price[2]),
            FlSpot(3, price[3] == -1 ? null : price[3]),
          ],
          isCurved: false,
          barWidth: 3.5,
          colors: [color],
          dotData: FlDotData(
            show: false,
          ),
        )
      );
    }
  }

  Widget _getword(List list){
    List newlist = List.from(list);
    newlist.removeWhere((e) => e[2] == false);
    double lineCnt = (newlist.length ~/ 4).toDouble();
    if(newlist.length % 4 != 0){
      int count = newlist.length % 4;
      for(int i = count; i < 4; i++){
        newlist.add(['-1',null]);
      }
    }
    List<Widget> result = [];
    for(int i = 0 ; i < newlist.length; i = i + 4){
      result.add(
        Row(
          children: [
            Expanded(
              flex: 1,
              child: newlist[i][0] != '-1' 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: newlist[i][1],
                    ),
                    SizedBox(width: 10),
                    Text(newlist[i][0]),
                  ],
                ) 
                : Container(),
            ),
            Expanded(
              flex: 1,
              child: newlist[i+1][0] != '-1' 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: newlist[i+1][1],
                    ),
                    SizedBox(width: 10),
                    Text(newlist[i+1][0]),
                  ],
                ) 
                : Container(),
            ),
            Expanded(
              flex: 1,
              child: newlist[i+2][0] != '-1' 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: newlist[i+2][1],
                    ),
                    SizedBox(width: 10),
                    Text(newlist[i+2][0]),
                  ],
                ) 
                : Container(),
            ),
            Expanded(
              flex: 1,
              child: newlist[i+3][0] != '-1' 
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: newlist[i+3][1],
                    ),
                    SizedBox(width: 10),
                    Text(newlist[i+3][0]),
                  ],
                ) 
                : Container(),
            ),
          ],
        )
      );
    }
    return Container(
      height: lineCnt * 30 + (lineCnt - 1) * 10,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children : result
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    _setlines(widget.list);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          height: 450,
          width: width - 40,
          //padding: EdgeInsets.symmetric(horizontal: 5),
          child: LineChart(
            LineChartData(
              lineBarsData: lines,
              minY: minY,
              maxY: 40,
              titlesData: FlTitlesData(
                bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (value) => TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    getTitles: (value) {
                      switch (value.toInt()) {
                        case 0:
                          return '大前天';
                        case 1:
                          return '前天';
                        case 2:
                          return '昨天';
                        case 3:
                          return '今天';
                        default:
                          return '';
                      }
                    }),
                leftTitles: SideTitles(
                  showTitles: true,
                  getTextStyles: (value) => TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  getTitles: (value) {
                    if(value.toInt() % 5 == 0){
                      return '\$ '+value.toInt().toString();
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
        _getword(detail),
        SizedBox(height: 70),
      ],
    );
  }
}
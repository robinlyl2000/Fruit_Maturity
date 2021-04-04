import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormPage extends StatefulWidget {
  final Map list;
  FormPage({this.list});
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  Widget _getData(Map listOfData) {
    List<DataRow> rows = [];
    final DateTime now = DateTime.now();
    final day1 = DateFormat('yyy.MM.dd').format(DateTime(now.year - 1911, now.month, now.day-2));
    final day2 = DateFormat('yyy.MM.dd').format(DateTime(now.year - 1911, now.month, now.day-1));
    final day3 = DateFormat('yyy.MM.dd').format(DateTime(now.year - 1911, now.month, now.day));
    
    for(int i = 0 ; i < widget.list.length ; i++){
      final location = widget.list.keys.elementAt(i);
      String price1, price2, price3 ;
      for(var x in widget.list[location]){
        if(x['TransDate']== day1){
          price1 = x['Avg_Price'].toStringAsFixed(1);
        }else if(x['TransDate'] == day2){
          price2 = x['Avg_Price'].toStringAsFixed(1);
        }else if(x['TransDate'] == day3){
          price3 = x['Avg_Price'].toStringAsFixed(1);
        }
      }
      rows.add(
        DataRow(cells: [
          DataCell(Text(
            location,
            style: TextStyle(
              fontSize: 16
            ),
          )),
          DataCell(Text(
            price2 ?? "—",
            style: TextStyle(
              fontSize: 14
            ),
          )),
          DataCell(Text(
            price2 ?? "—",
            style: TextStyle(
              fontSize: 14
            ),
          )),
          DataCell(Text(
            price3 ?? "—",
            style: TextStyle(
              fontSize: 14
            ),
          )),
        ])
      );
    }
    return DataTable(
      sortColumnIndex: 0,
      sortAscending: true,
      columns: [
            DataColumn(label:Text(
              '市場',
              style: TextStyle(
                fontSize: 20
              ),
            )),
            DataColumn(label: Text(
              '前日',
              style: TextStyle(
                fontSize: 20
              ),
            ),numeric: true),
            DataColumn(label: Text(
              '昨日',
              style: TextStyle(
                fontSize: 20
              ),
            ),numeric: true),
            DataColumn(label: Text(
              '今日',
              style: TextStyle(
                fontSize: 20
              ),
            ),numeric: true),
          ],
      rows: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text('單位: 元/公斤')
          ),
        ),
        _getData(widget.list),
      ],
    );
  }
}
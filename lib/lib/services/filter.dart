import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/Options.dart';

class FilterPage extends StatefulWidget {
  final String status;
  FilterPage({this.status});
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<String> _options = ['由舊到新','由新到舊','熱門度'].toList();
  String _selection;
  RangeValues values = RangeValues(1, 6);
  String label_start = '1';
  String label_end = '6';

  @override
  void initState(){
    _selection = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropdownMenuOptions = _options
      .map((String option) => DropdownMenuItem<String>(value: option, child: Text(option, style: TextStyle(color: Colors.white),),)).toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 130,
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: Color(0xff4b5553),
          ),
          child: Text(
            '排列順序',
            style: TextStyle(
              fontSize: 21,
              color: Colors.white
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 40,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.grey[850],
              ),
              child: DropdownButton(
                value: _selection,
                items: dropdownMenuOptions,
                onChanged: (s){
                  setState(() {
                    _selection = s;
                  });
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Divider(
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.center,
          width: 130,
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: Color(0xff4b5553),
          ),
          child: Text(
            '熟度範圍',
            style: TextStyle(
              fontSize: 21,
              color: Colors.white
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$label_start級',
              ),
              SizedBox(
                width: 260,
                child: RangeSlider(
                  activeColor: Colors.grey[850],
                  inactiveColor: Colors.grey[600],
                  values: values,
                  min: 1,
                  max: 6,
                  divisions: 5,
                  onChanged: (q){
                    setState(() {
                      values = q;
                      label_start = values.start.toInt().toString();
                      label_end = values.end.toInt().toString();
                    });
                  }
                ),
              ),
              Text('$label_end級'),
            ],
          ),
        ),
        SizedBox(height: 10),
        RaisedButton(
          child: Text(
            "確定",
            style: TextStyle(
              color: Colors.black
            ),
          ),
          color: Colors.white,
          onPressed: () {
            Options temp = Options(selection: _selection, start: values.start.toInt(), end: values.end.toInt());
            Navigator.pop(context, temp);
          },
        ),
      ],
    );
  }
}
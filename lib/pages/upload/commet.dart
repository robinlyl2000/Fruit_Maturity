import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/services/database.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:intl/intl.dart';


final AuthService _auth = AuthService();

class CommentPage extends StatefulWidget {
  final Imagesaving save;

  CommentPage({this.save});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {

  
  String _currentComment = '';
  List isSelected = <bool>[false, false, true];
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    double height = MediaQuery.of(context).size.height - 120;
    

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xffefcd62),
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          iconSize: 33,
          onPressed: (){
            Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
          },
        ),
        title: Text(' 新增評論'),
        centerTitle: true,
        backgroundColor: Color(0xff9aa153),
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height:20),
              SizedBox(
                width: 300,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        height: 200,
                        width: 180,
                        color: Color(0xffaa9964),
                        child: Image.file(
                          widget.save.file,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    SizedBox(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text(
                            '上傳者 :',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            '${widget.save.username}',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '熟度 :',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            '${widget.save.ratio.toStringAsFixed(1)}%',
                            style: TextStyle(
                              fontSize: 20
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '上傳日期 :',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(
                              fontSize: 18
                            ),
                          )
                        ]
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Text('選擇您發表的主題 : '),
              Container(
                alignment: Alignment.center,
                width: 300,
                height: 50,
                child: ToggleButtons(
                    color: Colors.black.withOpacity(0.60),
                    selectedColor: Color(0xff9aa153),
                    selectedBorderColor: Color(0xff9aa153),
                    fillColor: Color(0xff9aa153).withOpacity(0.08),
                    splashColor: Color(0xff9aa153).withOpacity(0.12),
                    hoverColor: Color(0xff9aa153).withOpacity(0.04),
                    borderRadius: BorderRadius.circular(4.0),
                    constraints: BoxConstraints(minHeight: 36.0),
                    isSelected: isSelected,
                    onPressed: (index) {
                        // Respond to button selection
                        setState(() {
                            isSelected[index] = !isSelected[index];
                            for(int i = 0 ; i < 3; i ++){
                              if(index != i && isSelected[index] == true){
                                isSelected[i] = false;
                              }
                            }
                        });
                    },
                    children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              '口感',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              '料理',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text(
                              '其他',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            ),
                        ),
                    ],
                )
              ),
              SizedBox(height: 15),
              Text('選擇留下您的評論 : '),
              SizedBox(height: 5),
              Container(
                width: 300,
                height: 150,
                child: TextFormField(
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: null,
                    maxLines: null, 
                    expands: true, 
                  decoration:InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400], width: 2.0) 
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0) 
                    ),
                  ),
                  validator: (val) {
                    return null;
                  },
                  onChanged: (val){
                    setState(() {
                      _currentComment = val;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              FlatButton.icon(
                icon: Icon(
                  Icons.send,
                  color: Color(0xff4a4053),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                onPressed: () async{
                  if(_currentComment == null || _currentComment == ''){
                    widget.save.comment = '(尚無評論)';
                  }else{
                    widget.save.comment = _currentComment ;
                  }
                  if(isSelected[0] == true){
                    widget.save.tag = '口感';
                  }else if(isSelected[1] == true){
                    widget.save.tag = '料理';
                  }else if(isSelected[2] == true){
                    widget.save.tag = '其他';
                  }else{
                    widget.save.tag = '其他';
                  }
                  widget.save.likenum = 0;
                  widget.save.username = await DatabaseService().getusername(widget.save.userid);
                  await DatabaseService(userid : widget.save.userid).updateImageData(widget.save, true);
                  Navigator.of(context).pushNamedAndRemoveUntil('/wrapper', (Route<dynamic> route) => false);
                },
                color: Color(0xffdd4341), 
                label: Text(
                  '確定',
                  style: TextStyle(
                    color: Color(0xff4a4053),
                  ),  
                ),
              ),
              Spacer(),
              Container(
                height: 60,
                color: Color(0xff9aa153),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
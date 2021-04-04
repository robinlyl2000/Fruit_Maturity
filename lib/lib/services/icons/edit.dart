import 'package:flutter/material.dart';
import 'package:pineapple_demo3/model/imageSaving.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:pineapple_demo3/services/database.dart';

class EditPage extends StatefulWidget {

  final Imagesaving save;

  EditPage({this.save});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  AuthService _auth = AuthService();
  TextEditingController _controller = TextEditingController();

    Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('確認修改此評論?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('確定'),
              onPressed: () async{
                await DatabaseService(userid : widget.save.userid, imageID: widget.save.imageID).updateImageData(widget.save, false);
                Navigator.pop(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _controller.text = widget.save.comment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('編輯評論'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
                color: Colors.white,
              ),
            label: Text(
              '登出',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: () async {
                await _auth.signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Image.network(widget.save.url),
            ),
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '時間 : ${widget.save.time}\n熟度 : ${widget.save.ratio}%\n分級 : ${widget.save.getlevel()}級',
                  textAlign : TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey[700],
                  ), 
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: 300,
                child: TextFormField(
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  minLines: null,
                  maxLines: null, 
                  expands: true, 
                  controller: _controller,
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
                    if(val.isEmpty){
                      return '評論不得空白';
                    }else{
                      return null;
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      widget.save.comment = val;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    color: Colors.grey[700], 
                    child: Text(
                      '取消修改',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),  
                    ),
                  ),
                  SizedBox(width: 15),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: (){
                      _showMyDialog();
                    },
                    color: Colors.grey[700], 
                    child: Text(
                      '確定修改',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),  
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
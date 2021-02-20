import 'package:pineapple_demo1/services/auth.dart';
import 'package:pineapple_demo1/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:pineapple_demo1/services/constants.dart';

class Register extends StatefulWidget {

 final Function toggleView;
 Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String name = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0.0,
        title: Text('註冊帳號'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              '會員登入',
              style: TextStyle(
                color: Colors.white
              ),
            ),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: '請輸入您的姓名'),
                validator: (val) {
                  if(val.isEmpty){
                    return '姓名不得空白';
                  }else{
                    return null;
                  }
                },
                onChanged: (val){
                  setState(() {
                    name = val;
                  });
                },
              ),
              SizedBox(height : 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: '請輸入您的信箱'),
                validator: (val) {
                  if(val.isEmpty){
                    return '信箱不得空白';
                  }else{
                    return null;
                  }
                },
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height : 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: '請輸入您的密碼'),
                validator: (val) {
                  if(val.length < 6){
                    return '密碼長度須大於6個字母';
                  }else{
                    return null;
                  }
                },
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height : 20.0),
              RaisedButton(
                color: Colors.grey[700],
                child: Text(
                  '註冊',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerWithEmailAndPassword(name, email, password);
                    if(result == null){
                      setState(() {
                        error = '請輸入正確的信箱格式';
                        loading = false;
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
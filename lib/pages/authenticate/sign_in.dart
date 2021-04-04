import 'package:pineapple_demo3/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:pineapple_demo3/services/auth.dart';
import 'package:pineapple_demo3/services/constants.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  Image bgImage;
  Image titleImage;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  void initState(){
    super.initState();
    bgImage = Image.asset('assets/bg_01.jpg');
    titleImage = Image.asset('assets/title.png');    
  }

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    await precacheImage(bgImage.image, context);
    await precacheImage(titleImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: bgImage.image,
            fit: BoxFit.cover,
          ),
          color: Color(0xffefcd62)
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Spacer(flex: 20),
                      Container(
                        height: 150,
                        child: Image(
                          fit: BoxFit.fitHeight,
                          image: titleImage.image,
                        ),
                      ),
                      Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 45,
                          color: Colors.black,
                          fontFamily: 'Brushsci',
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        style: TextStyle(
                          color: Color(0xff483e1e),
                        ),
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
                      SizedBox(height: 15),
                      TextFormField(
                        style: TextStyle(
                          color: Color(0xff483e1e),
                        ),
                        decoration: textInputDecoration.copyWith(hintText: '請輸入您的密碼'),
                        obscureText: true,
                        validator: (val) {
                          if(val.isEmpty){
                            return '密碼不得空白';
                          }else{
                            return null;
                          }
                        },
                        onChanged: (val){
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      Text(
                        error,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0
                        )
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            height: 45,
                            width: 150,
                            child: RaisedButton(
                              color: Color(0xffdd4341),
                              child: Text(
                                '確定登入',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                              ),
                              onPressed: () async {
                                if(_formKey.currentState.validate()){
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                  if(result == null){
                                    setState(() {
                                      error = '信箱或密碼錯誤';
                                      loading = false;
                                    });
                                  }
                                }
                                FocusScope.of(context).requestFocus(new FocusNode());
                              },
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 45,
                            width: 150,
                            child: RaisedButton(
                              color: Colors.grey[700],
                              child: Text(
                                '註冊帳號',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                              ),
                              onPressed: (){
                                widget.toggleView();
                              },
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 30),
                    ],
                  ),
                ),
              ]
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 50,
        color: Color(0xff9aa153),
        child: Center(
          child: Text(
            '2021@CCUMIS',
            style : TextStyle(
              fontSize: 18,
              color: Color(0xff4d5029)
            ),
          ),
        ),
      ),
    );
  }
}
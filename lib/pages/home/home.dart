import 'package:flutter/material.dart';
import 'package:pineapple_demo1/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Fruit Maturity'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(70.0, 0.0, 70.0,0.0),
            child: Image(
              image: AssetImage('assets/nice.png'),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200,
                child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  icon: Icon(
                    Icons.photo,
                    color: Colors.white,
                  ),
                  onPressed: ((){
                    Navigator.of(context).pushNamed('/upload');
                  }),
                  label: Text(
                    '新增照片',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),  
                  ),
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(
                width: 200,
                child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  icon: Icon(
                    Icons.collections,
                    color: Colors.white,
                  ),
                  onPressed: ((){
                    Navigator.of(context).pushNamed('/selfpage');
                  }),
                  label: Text(
                    '上傳紀錄',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),  
                  ),
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(
                width: 200,
                child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  icon: Icon(
                    Icons.view_comfy,
                    color: Colors.white,
                  ),
                  onPressed: ((){
                    Navigator.of(context).pushNamed('/allpage');
                  }),
                  label: Text(
                    '所有用戶之紀錄',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),  
                  ),
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
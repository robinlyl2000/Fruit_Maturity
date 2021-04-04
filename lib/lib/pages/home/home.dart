import 'package:flutter/material.dart';
import 'package:pineapple_demo3/services/auth.dart';


class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffefcd62),
      appBar: AppBar(
        title: Image(
          image: AssetImage('assets/icon.png'),
          fit: BoxFit.cover,
          height: 65,
        ),
        backgroundColor: Color(0xff9aa153),
        elevation: 0.0,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(70.0, 0.0, 70.0,30.0),
            child: Image(
              image: AssetImage('assets/background.png'),
            ),
          ),
        ],
      ),
      bottomSheet: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 80,
            color: Color(0xff9aa153),
          ),
          Container(
            height: 10,
            color: Color(0xffefcd62),
          ),
          Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Spacer(flex: 2),
                    FlatButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/pricepage');
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.explore_rounded,
                            size: 30,
                          ),
                          Text('時價地圖')
                        ],
                      )
                    ),
                    Spacer(flex: 10),
                    FlatButton(
                      child: Column(
                        children: [
                          Icon(
                            Icons.grid_view,
                            size: 30,
                          ),
                          Text('上傳紀錄')
                        ],
                      ),
                      onPressed: (){
                        Navigator.of(context).pushNamed('/commentpage');
                      }
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushNamed('/upload');
            },
            child: Image.asset(
              'assets/test.png',
              fit: BoxFit.fitHeight,
              height: 80,
            ),
          ),
          Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 19),
                IconButton(
                  icon: Icon(Icons.add),
                  iconSize: 45,
                  onPressed: (){
                    Navigator.of(context).pushNamed('/upload');
                  }
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitPageTwo extends StatefulWidget {
  @override
  _InitPageTwoState createState() => _InitPageTwoState();
}

class _InitPageTwoState extends State<InitPageTwo> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uuid');
    print('uuid:');
    print(uuid);

    var _someDuration = new Duration(seconds: 2);
    var _zeroDuration = new Duration(seconds: 1);

    if (uuid != null) {
//已经登陆了
      return new Timer(_zeroDuration, navigationPageHome);
    } else {
      // First time
      prefs.setBool('first_time', false);
      return new Timer(_someDuration, navigationPageWel);
    }
  }

  void navigationPageWel() {
    Navigator.of(context).pushReplacementNamed('LogIn');
  }

  void navigationPageHome() {
    Navigator.of(context).pushReplacementNamed('Navigator');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, 'LogIn');
      },
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(flex: 2, child: Container()),
              Expanded(
                  flex: 3,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 200,
                        child: Center(
                          child: Image(image: AssetImage('assets/Icon.jpg')),
                        ),
                      ),
                      Center(
                        child: Text(
                          'CThrough',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              fontSize: 30.0,
                              //fontFamily: 'Cinzel',
                              fontWeight: FontWeight.w100),
                        ),
                      ),
                      Center(
                        child: Text(
                          '帮助你的决策',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
              Expanded(flex: 1, child: Container()),
              Center(
                child: Text(
                  '点击继续',
                  textScaleFactor: 2,
                  style:
                      TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
                ),
              ),
              Expanded(flex: 1, child: Container()),
            ]),
      ),
    );
  }
}

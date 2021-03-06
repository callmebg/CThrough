import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_matching/pages/widget_persontile_utility.dart';

//用于异步读取本地json

// Future<String> _loadDocumentFile() async {
//   return await rootBundle.loadString('lib/assets/Document.json');
// }

// Future wait(int milliseconds) {
//   return new Future.delayed(Duration(milliseconds: milliseconds), () => {});
// }

// Future<PersonTileData> loadDocument() async {
//   await wait(1000);
//   String jsonString = await _loadDocumentFile();
//   final jsonResponse = json.decode(jsonString);
//   return new PersonTileData.fromJson(jsonResponse);
// }

//我的个人信息标签
class MyPersonTile extends StatefulWidget {
  @override
  _MyPersonTileState createState() => _MyPersonTileState();
}

class _MyPersonTileState extends State<MyPersonTile> {
  Widget futureWidget() {
    PersonTileData personTileData = PersonTileData(
      uuid: 'default',
      avatarId: 1,
      userName: '正在加载昵称',
      userIdentity: '正在加载身份',
      followed: 0,
    );

    Future<bool> Faliure() async {
      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('无法获取个人信息'),
              content: new Text('请稍后再试'),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('确定'),
                ),
              ],
            ),
          )) ??
          false;
    }

    //get uuid from local shared_preference
    Future<String> getUuid() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //set uuid
      personTileData.uuid = prefs.getString('uuid');
      return personTileData.uuid;
    }

    Future<Null> GetPersonTileData() async {
      var myuuid = await getUuid();
      print('begin async');
      Response response;
      print('before try:');
      print(myuuid);
      try {
        var data = {'uuid': myuuid};
        print('when try:');
        print(myuuid);
        response = await post(
          "http://47.107.117.59/fff/getUserInfo.php",
          body: data,
        );
        Map<String, dynamic> mapFromJson =
            json.decode(response.body.toString());
        print(mapFromJson);
        print(data);
        print(personTileData.uuid);
        if (mapFromJson['status'] == 10000) {
          print('请求成功');
          personTileData.avatarId = mapFromJson['avartarId'];
          personTileData.followed = mapFromJson['followed'];
          personTileData.userIdentity = mapFromJson['identity'];
          personTileData.userName = mapFromJson['nick'];
          print(personTileData.avatarId);
          print(personTileData.userName);
        } else if (mapFromJson['status'] == 20000) {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text("请求失败"),
            action: new SnackBarAction(
              label: "OK",
              onPressed: () {},
            ),
          ));
        }
      } on Error catch (e) {
        print(e);
        Faliure();
      }
      return;
    }

    return new FutureBuilder<PersonTileData>(
        future: GetPersonTileData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Text(
                  'Press button to start'); //如果_calculation未执行则提示：请点击开始
            case ConnectionState.waiting:
              return new Text('Awaiting result...'); //如果_calculation正在执行则提示：加载中
            default: //如果_calculation执行完毕
              if (snapshot.hasError) //若_calculation执行出现异常
                return new Text('Error: ${snapshot.error}');
              else //若_calculation执行正常完成
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 0,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: new BigPersonalTile(
                    //在futur builder 中返回一个个人资料栏
                    userName: personTileData.userName,
                    userIdentity: personTileData.userIdentity,
                    followed: personTileData.followed,
                    avatarId: personTileData.avatarId,
                  ),
                );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return futureWidget();
  }
}

//我的个人信息页面
class DocumentPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    //below are only for Provider-Consumer
    // final ultimateGoal1 = Provider.of<NameAndMessage>(context).ultimateGoal1;
    // final ultimateGoal2 = Provider.of<NameAndMessage>(context).ultimateGoal2;
    // final ultimateGoal3 = Provider.of<NameAndMessage>(context).ultimateGoal3;
    //final Image avatar;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, 'EditProfileScreen');
          },
          icon: Icon(Icons.edit),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.alternate_email),
            onPressed: () {
              Navigator.pushNamed(context, 'AboutPage');
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: <Widget>[
          MyPersonTile(),
          
          
        ],
      ),
    );
  }
}

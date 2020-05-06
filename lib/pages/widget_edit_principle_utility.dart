import 'package:date_matching/pages/widget_my_goals_view.dart';
import 'package:flutter/material.dart';




List listOfBarePrinciple = List<BarePrinciple>();

class BarePrinciple {
  String puid;
  String principleText;
  String principleDescription;
  factory BarePrinciple.fromJson(Map<String, dynamic> parsedJson) {
    return BarePrinciple(
      puid: parsedJson['puid'],
      principleText: parsedJson['principleText'],
      principleDescription: parsedJson['principleDescription'],
    );
  }

  BarePrinciple({this.puid, this.principleText, this.principleDescription});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['puid'] = this.puid;
    data['principle_text'] = this.principleText;
    data['principle_description'] = this.principleDescription;
    return data;
  }
}


//https://javiercbk.github.io/json_to_dart/
//最基本的最重要的五步方法数据结构,包括从JSON到类和创建JSON
class BarePrincipleList {
  List<BarePrinciple> barePrinciples;

  BarePrincipleList({this.barePrinciples});

  BarePrincipleList.fromJson(Map<String, dynamic> json) {
    if (json['BarePrinciple'] != null) {
      barePrinciples = new List<BarePrinciple>();
      json['BarePrinciple'].forEach((v) {
        barePrinciples.add(new BarePrinciple.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.barePrinciples != null) {
      data['BarePrinciple'] =
          this.barePrinciples.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


//两行字(最多四行)
class SmallPrincipleDescription extends StatelessWidget {
  SmallPrincipleDescription({
    Key key,
    this.principleText,
    this.principleDescription,
  }) : super(key: key);
  final String principleText;
  final String principleDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$principleText',
              textScaleFactor: 1.4,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              '$principleDescription',
              textScaleFactor: 1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//可以放很多行
class FullPrincipleDescription extends StatelessWidget {
  FullPrincipleDescription({
    Key key,
    this.principleText,
    this.principleDescription,
  }) : super(key: key);
  final String principleText;
  final String principleDescription;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$principleText',
              textScaleFactor: 2.2,
              overflow: TextOverflow.ellipsis,
              maxLines: 100,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            Text(
              '$principleDescription',
              textScaleFactor: 1.5,
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//给两行字加上圆角矩形
class PrincipleCard extends StatelessWidget {
  PrincipleCard({
    Key key,
    this.principleText,
    this.principleDescription,
  }) : super(key: key);
  final String principleText;
  final String principleDescription;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            //color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: SmallPrincipleDescription(
            principleDescription: principleDescription,
            principleText: principleText,
          ),
        ),
      ),
    );
  }
}

//可以变长的卡片
class FullPrincipleCard extends StatelessWidget {
  FullPrincipleCard({
    Key key,
    this.principleText,
    this.principleDescription,
  }) : super(key: key);
  final String principleText;
  final String principleDescription;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 20),
          child: FullPrincipleDescription(
            principleText: principleText,
            principleDescription: principleDescription,
          ),
        ),
      ),
    );
  }
}

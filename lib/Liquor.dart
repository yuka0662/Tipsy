import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import './Color.dart';
import './main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:tipsy/Top.dart';

var logo = 'images/FavoriteLiquor.PNG'; //診断のロゴ
double lhei0 = 200; //ロゴの高さ(スタート画面専用)
double lhei = 150; //ロゴの高さ数値

class Liquor extends StatefulWidget {
  @override
  Listate createState() => new Listate();
}

//診断スタート画面
class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String text = 'Start';
    String text1 = 'あなた好みのお酒をおすすめします!';

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 90, 0, 0)),
            //ロゴ
            Container(
              height: lhei0,
              margin: EdgeInsets.only(bottom: 30),
              child: Image.asset(logo),
            ),
            //テキスト表示
            Container(
              height: 70,
              child: Center(
                child: Text(
                  text1,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            //スタートボタン
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: RaisedButton(
                            color: HexColor('212738'),
                            child: Text(text,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Liquor(),
                                ),
                              );
                            })),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Listate extends State {
  //質問と選択肢を昇順で取得
  var liquor;
  Future getState() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('liqueur')
        .orderBy('id')
        .snapshots()) {
      liquor = liquor ?? [];
      for (var like in snapshot.docs) {
        setState(() {
          liquor.add(like.data());
        });
      }
    }
  }

  var lans;
  Future getansState() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('liquor_ans')
        .orderBy('id')
        .snapshots()) {
      lans = lans ?? [];
      for (var like in snapshot.docs) {
        setState(() {
          lans.add(like.data());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getState();
    getansState();
  }

  var _cnt = 0;
  int a = 0; //答えの番号を格納する変数

//問題・選択肢表示、結果画面遷移
  @override
  Widget build(BuildContext context) {
    if (liquor != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.all(20)),
              Container(
                height: lhei,
                child: Image.asset(logo),
              ),
              Container(
                height: 70,
                child: Center(
                  child: Text(
                    liquor[_cnt]['question'].toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 1; i < liquor[_cnt].length / 2; i++)
                        SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: RaisedButton(
                                color: HexColor('212738'),
                                child: Text(
                                    liquor[_cnt]['option${i}'].toString(),
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white)),
                                onPressed: () async {
                                  if (100 > liquor[_cnt]['next${i}']) {
                                    setState(() {
                                      _cnt = liquor[_cnt]['next${i}'] - 1;
                                    });
                                  } else {
                                    setState(() {
                                      a = liquor[_cnt]['next${i}'] - 101;
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('ans_keep')
                                        .doc(AuthModel().user.email)
                                        .collection('ans_no')
                                        .doc(a.toString())
                                        .set({
                                      'name': lans[a]['name'],
                                      'image': lans[a]['images'],
                                      'detail': lans[a]['ans']
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Ans(a),
                                      ),
                                    );
                                  }
                                })),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Text(''),
      );
    }
  }
}

class Ans extends StatefulWidget {
  @override
  Ans_state createState() => new Ans_state(_a);
  Ans(this._a);
  final int _a;
}

class Ans_state extends State {
  Ans_state(this._a);
  final int _a;

  var lans;
  Future getansState() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('liquor_ans')
        .orderBy('id')
        .snapshots()) {
      lans = lans ?? [];
      for (var like in snapshot.docs) {
        setState(() {
          lans.add(like.data());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getansState();
  }

  @override
  Widget build(BuildContext context) {
    if (lans != null) {
      return Scaffold(
          body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
          Container(
            child: CachedNetworkImage(
              imageUrl: lans[_a]["images"],
              errorWidget: (conte, url, dynamic error) =>
                  Image.asset('assets/InPreparation_sp.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(5),
            child: Flexible(
              child: Text(
                lans[_a]['name'],
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Text(lans[_a]['ans'],
                      style: TextStyle(fontSize: 15, letterSpacing: 4.0)))),
          RaisedButton(
              color: HexColor('212738'),
              child: Text('もう一度診断する',
                  style: TextStyle(fontSize: 15, color: Colors.white)),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Start(),
                  ),
                );
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Start(),
                  ),
                );
              }),
        ]),
      ));
    } else {
      return Scaffold(
        body: Text(''),
      );
    }
  }
}

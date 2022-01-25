import 'package:flutter/material.dart';
import 'dart:math';
import './Color.dart';
import './main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
//import 'package:tipsy/Top.dart';

var logo = 'images/FavoriteLiquor.PNG'; //診断のロゴ
double lhei0 = 100; //ロゴの高さ(スタート画面専用)
double lhei = 150; //ロゴの高さ数値

class Liquor extends StatefulWidget {
  @override
  Listate createState() => new Listate();
}

class LiquorStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: licho.length,
        child: Scaffold(
          body: Center(
            child: Licho2(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Licho {
  String label;
  Widget widget;

  Licho(this.label, this.widget);
}

final List<Licho> licho = [Licho('お酒診断', Start()), Licho('診断履歴', LiquorLog())];

class Licho2 extends StatefulWidget {
  @override
  _LiquorCardState createState() => _LiquorCardState();
}

class _LiquorCardState extends State<Licho2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: //AppBar(
            //bottom:
            PreferredSize(
          child: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: HexColor('43AA8B'),
            indicatorColor: HexColor('43AA8B'),
            tabs: licho.map((Licho licho2) {
              return Tab(
                text: licho2.label,
              );
            }).toList(),
          ),
          preferredSize: Size.fromHeight(15.0),
        ),
        backgroundColor: HexColor('f5f5f5'),
        //),
        body: TabBarView(children: licho.map((tab) => tab.widget).toList()),
      ),
    );
  }
}

class LiquorLog extends StatefulWidget {
  @override
  _LiquorLogState createState() => _LiquorLogState();
}

class _LiquorLogState extends State {
  var keepans;
  Future getanskeep() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('ans_keep')
        .doc(AuthModel().user.email)
        .collection('ans_no')
        .snapshots()) {
      keepans = keepans ?? [];
      for (var ans in snapshot.docs) {
        setState(() {
          keepans.add(ans.data());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getanskeep();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
        itemCount: keepans == null ? 0 : keepans.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Ans(keepans[index]['id']),
                ),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Ans(keepans[index]['id']),
                ),
              );
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    width: 150,
                    height: 150,
                    imageUrl: keepans[index]['image'],
                    errorWidget: (conte, url, dynamic error) =>
                        Image.asset('assets/InPreparation_sp.png'),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            keepans[index]['name'],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
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
            //Padding(padding: EdgeInsets.fromLTRB(0, 90, 0, 0)),
            //ロゴ
            Container(
              height: 260,
              margin: EdgeInsets.only(top: 20),
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
                height: 70,
                child: Center(
                  child: Text(
                    liquor[_cnt]['question'].toString(),
                    style: TextStyle(fontSize: 20),
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
                                      'id': a,
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
      return ListView(
          /*body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          */
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
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
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text('${lans[_a]['ans']}\n',
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 4.0,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none)))),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: RaisedButton(
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
              //));
            )
          ]);
    } else {
      return Scaffold(
        body: Text(''),
      );
    }
  }
}

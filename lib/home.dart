import 'package:flutter/material.dart';
import './Top.dart';
import './Color.dart';
import './API/cocktails.dart';
import './API/osakeAPI.dart';
import './API/snacksAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:another_flushbar/flushbar.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          body: Center(
            child: ChoiceCard(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Choice {
  String label;
  Widget widget;

  Choice(this.label, this.widget);
}

final List<Choice> choices = [
  Choice('ホーム', Top()),
  Choice('ビール', Beer()),
  Choice('日本酒', Sake()),
  Choice('ワイン', Wine()),
  Choice('ウイスキー', Whisky()),
  Choice('焼酎', Shochu()),
  Choice('リキュール', Liqueur()),
  Choice('カクテル', Cocktail()),
  //Choice('おつまみ', Snacks()),
];

class ChoiceCard extends StatefulWidget {
  @override
  _ChoiceCardState createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: HexColor('43AA8B'),
          indicatorColor: HexColor('43AA8B'),
          isScrollable: true,
          tabs: choices.map((Choice choice) {
            return Tab(
              text: choice.label,
            );
          }).toList(),
        ),
        body: TabBarView(children: choices.map((tab) => tab.widget).toList()),
      ),
    );
  }
}

class Cocktail extends StatelessWidget {
  List<List<String>> word = [
    [
      'ジン',
      'ウォッカ',
      'テキーラ',
      'ラム',
      'ウィスキー',
      'ブランデー',
      'リキュール',
      'ワイン',
      'ビール',
      '日本酒',
      'ノンアルコール'
    ],
    ['ビルド', 'ステア', 'シェイク'],
    ['甘口', '中甘口', '中口', '中辛口', '辛口'],
    ['ショート', 'ロング'],
    ['食前', '食後', 'オール']
  ];
  var array = ['ベース選択', '技法選択', '味わい選択', 'スタイル選択', 'TOP選択'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
        itemCount: array == null ? 0 : array.length, //受け取る数の定義
        itemBuilder: (BuildContext context, int index) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(5, 10.0, 0, 10.0),
                  child: Text(
                    array[index],
                    style: TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 5.0,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _children(context, index),
                  ),
                ),
              ]);
        });
  }

  List<Widget> _children(BuildContext context, int cnt) =>
      List<Widget>.generate(
          word[cnt].length,
          (index) => Padding(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CocktailsAll(word[cnt][index])));
                },
                child: Container(
                    height: 100,
                    width: 140,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            left: BorderSide(
                                color: HexColor('212738'), width: 7))),
                    child: Center(
                      child: Text(
                        word[cnt][index],
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              )));
}

class Snacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[],
    );
  }
}

class RecipeDetail extends StatefulWidget {
  RecipeDetail(
      this._id,
      this._cocktailname,
      this._englishname,
      this._base,
      this._technique,
      this._taste,
      this._style,
      this._alcohol,
      this._topname,
      this._glass,
      this._digest,
      this._desc,
      this._recipe,
      this._recipes,
      this._favorite,
      this._email);
  final int _id;
  final String _cocktailname;
  final String _englishname;
  final String _base;
  final String _technique;
  final String _taste;
  final String _style;
  final String _alcohol;
  final String _topname;
  final String _glass;
  final String _digest;
  final String _desc;
  final String _recipe;
  final List _recipes;
  final bool _favorite;
  final String _email;

  @override
  _RecipeDetailState createState() => new _RecipeDetailState(
      _id,
      _cocktailname,
      _englishname,
      _base,
      _technique,
      _taste,
      _style,
      _alcohol,
      _topname,
      _glass,
      _digest,
      _desc,
      _recipe,
      _recipes,
      _favorite,
      _email);
}

class _RecipeDetailState extends State {
  _RecipeDetailState(
      this._id,
      this._cocktailname,
      this._englishname,
      this._base,
      this._technique,
      this._taste,
      this._style,
      this._alcohol,
      this._topname,
      this._glass,
      this._digest,
      this._desc,
      this._recipe,
      this._recipes,
      this._favorite,
      this._email);
  final int _id;
  final String _cocktailname;
  final String _englishname;
  final String _base;
  final String _technique;
  final String _taste;
  final String _style;
  final String _alcohol;
  final String _topname;
  final String _glass;
  final String _digest;
  final String _desc;
  final String _recipe;
  final List _recipes;
  final bool _favorite;
  final String _email;

  String _text = '';
  final myController = TextEditingController();

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  List messageList;
  Future getMessage() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('comments')
        .doc('id')
        .collection(_id.toString())
        .snapshots()) {
      messageList = [];
      for (var message in snapshot.docs) {
        setState(() {
          messageList.add(message.data());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getMessage();
    changeState();
  }

  void showTopSnacmBar(BuildContext context) => Flushbar(
        message: '通報しました。',
        duration: Duration(seconds: 4),
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context);

  var alreadySaved;

  void changeState(){
    alreadySaved = _favorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: ListView(children: [
          Text(_digest,
              style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                  color: Colors.grey,
                  decoration: TextDecoration.none)),
          Text(_cocktailname,
              style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                  color: Colors.black,
                  decoration: TextDecoration.none)),
          Text(_englishname,
              style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                  color: Colors.black,
                  decoration: TextDecoration.none)),
          Row(children: [
            CachedNetworkImage(
              width: 140,
              height: 170,
              imageUrl: 'https://dm58o2i5oqos8.cloudfront.net/photos/' +
                  _id.toString() +
                  '.jpg',
              errorWidget: (conte, url, dynamic error) =>
                  Image.asset('assets/InPreparation_sp.png'),
            ),
            Flexible(
              child: Text(
                  '\nBase:' +
                      _base +
                      '\nTec:' +
                      _technique +
                      '\nTaste:' +
                      _taste +
                      '\nStyle:' +
                      _style +
                      '\nAlc.:' +
                      _alcohol +
                      '%\nTop:' +
                      _topname +
                      '\nGlass:' +
                      _glass +
                      '\n\n',
                  style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 5.0,
                      color: Colors.black,
                      decoration: TextDecoration.none)),
            ),
          ]),
          Text(_desc + '\n',
              style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                  color: Colors.black,
                  decoration: TextDecoration.none)),
          Text('材料',
              style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 5.0,
                  color: Colors.black,
                  decoration: TextDecoration.none)),
          for (int i = 0; i < _recipes.length; i++)
            Container(
              decoration: BoxDecoration(
                  border: const Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: ListTile(
                  title: Row(
                children: [
                  Container(
                    width: 250,
                    child: Text(
                      _recipes[i]["ingredient_name"],
                    ),
                  ),
                  Text(_recipes[i]["amount"] + _recipes[i]["unit"])
                ],
              )),
            ),
          Text('\n手順',
              style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 5.0,
                  color: Colors.black,
                  decoration: TextDecoration.none)),
          Text(_recipe + '\n',
              style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                  color: Colors.blueGrey,
                  decoration: TextDecoration.none)),
          Text("コメント",
              style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 5.0,
                  color: Colors.black,
                  decoration: TextDecoration.none)),
          Column(
            children: messageList?.map((document) {
                  return Container(
                    decoration: new BoxDecoration(
                      border: new Border(
                        bottom: new BorderSide(color: Colors.grey),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        '${document['nickname']}さん\n${document['comment']}',
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("このコメントを通報しますか？"),
                                content: Text(
                                    "ニックネーム：${document['nickname']}さん\nコメント：${document['comment']}"),
                                actions: <Widget>[
                                  // ボタン領域
                                  FlatButton(
                                    child: Text("キャンセル"),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  FlatButton(
                                    child: Text("通報する"),
                                    onPressed: () async {
                                      try {
                                        var data = {
                                          'comment': document['comment'],
                                          'email': document['email'],
                                        };
                                        await FirebaseFirestore.instance
                                            .collection('com_notice')
                                            .doc()
                                            .set(data);
                                      } catch (e) {
                                        print("${e.toString()}");
                                      }
                                      Navigator.pop(context);
                                      showTopSnacmBar(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "通報",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  );
                })?.toList() ??
                [],
          ),
          Row(children: [
            Expanded(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'コメント入力'),
                  onChanged: _handleText,
                  controller: myController,
                ),
              ),
            ),
            Container(
              child: IconButton(
                onPressed: () async {
                  try {
                    DocumentSnapshot docSnapshot = await FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(_email)
                        .get();
                    Map<String, dynamic> record = docSnapshot.data();
                    var data = {
                      'nickname': record['nickname'],
                      'comment': _text,
                      'email': _email,
                    };
                    await FirebaseFirestore.instance
                        .collection('comments')
                        .doc('id')
                        .collection(_id.toString())
                        .doc()
                        .set(data);
                    myController.clear();
                  } catch (e) {
                    print("${e.toString()}");
                  }
                },
                icon: Icon(
                  Icons.send_rounded,
                  color: HexColor('212738'),
                ),
              ),
            ),
          ]),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
          ),
        ]),
      ),
      floatingActionButton: Container(
        //margin: EdgeInsets.only(right: 160),
        child: FloatingActionButton(
          onPressed: () async {
            try {
              if (alreadySaved == false) {
                setState(() {
                  alreadySaved = !alreadySaved;
                });
                await FirebaseFirestore.instance
                    .collection('favorites')
                    .doc(_email)
                    .collection('カクテル')
                    .doc(_id.toString())
                    .set({
                  'id': _id,
                  'digest': _digest,
                  'name': _cocktailname,
                  'ename': _englishname,
                  'base': _base == null ? 'なし' : _base,
                  'technique': _technique,
                  'taste': _taste,
                  'style': _style,
                  'alcohol': _alcohol.toString(),
                  'topname': _topname,
                  'glass': _glass,
                  'desc': _desc,
                  'recipe': _recipe,
                  'recipes': _recipes,
                  'state': alreadySaved
                });
              } else {
                setState(() {
                  alreadySaved = !alreadySaved;
                });
                await FirebaseFirestore.instance
                    .collection('favorites')
                    .doc(_email)
                    .collection('カクテル')
                    .doc(_id.toString())
                    .delete();
              }
            } catch (e) {
              print("${e.toString()}");
            }
          },
          child: alreadySaved
              ? Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              : Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
          backgroundColor: Colors.grey,
        ),
      ),
    );
  }
}

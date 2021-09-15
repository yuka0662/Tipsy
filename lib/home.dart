import 'package:flutter/material.dart';
import './Top.dart';
import './Color.dart';
import './API/cocktails.dart';
import './API/osakeAPI.dart';
import './API/snacksAPI.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      this._recipes);
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
      _recipes);
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
      this._recipes);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Text(_recipe + '\n\n\n\n',
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
          
        ]),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(right: 160),
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.favorite_border,
              ),
              backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

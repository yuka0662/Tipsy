import 'package:flutter/material.dart';
import './Color.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

//検索詳細画面
class _State extends State {

  //価格帯設定dropdownmenuの初期設定
  List<DropdownMenuItem<int>> _minitems = List();
  List<DropdownMenuItem<int>> _maxitems = List();
  int _minselectItem = 0;
  int _maxselectItem = 0;

  @override
  void initState() {
    super.initState();
    minsetItems();
    maxsetItems();
    _minselectItem = _minitems[0].value;
    _maxselectItem = _maxitems[0].value;
  }

  //Min価格設定のselectItems
  void minsetItems() {
    _minitems
      ..add(DropdownMenuItem(
        child: Text(
          '　　　　',
          style: TextStyle(fontSize: 15.0),
        ),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '0',
          style: TextStyle(fontSize: 15.0),
        ),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '500',
          style: TextStyle(fontSize: 15.0),
        ),
        value: 3,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '1000',
          style: TextStyle(fontSize: 15.0),
        ),
        value: 4,
      ));
  }

  //Max価格設定のselectItems
  void maxsetItems() {
    _maxitems
      ..add(DropdownMenuItem(
        child: Text(
          '　　　　',
          style: TextStyle(fontSize: 15.0),
        ),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '500',
          style: TextStyle(fontSize: 15.0),
        ),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '1000',
          style: TextStyle(fontSize: 15.0),
        ),
        value: 3,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '5000',
          style: TextStyle(fontSize: 15.0),
        ),
        value: 4,
      ));
  }

  //checkboxお酒カテゴリーの初期設定
  var _beer = false;
  var _sake = false;
  var _wine = false;
  var _sour = false;
  var _whisky = false;
  var _shochu = false;
  var _liqueur = false;
  var _cocktail = false;

  //checkboxおつまみカテゴリーの初期設定
  var _meat = false;
  var _fish = false;
  var _sweet = false;
  var _salty = false;
  var _easy = false;
  var _snack = false;
  var _novelty = false;
  var _party = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('絞り込み'),
          centerTitle: true,
          backgroundColor:HexColor('212738'),
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              Container(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                    'キーワード',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  )),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(hintText: "キーワードを入力してね"),
              ))
            ]),
            Text(
              'お酒のカテゴリー',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: CheckboxListTile(
                  value: _beer,
                  title: Text('ビール'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _beer = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _sake,
                  title: Text('日本酒'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _sake = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _wine,
                  title: Text('ワイン'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _wine = value;
                    });
                  },
                ),
              ),
            ]),
            Row(children: <Widget>[
              Expanded(
                child: CheckboxListTile(
                  value: _sour,
                  title: Text('サワー'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _sour = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _whisky,
                  title: Text('ウイスキー'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _whisky = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _shochu,
                  title: Text('焼酎'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _shochu = value;
                    });
                  },
                ),
              ),
            ]),
            Row(children: <Widget>[
              Expanded(
                child: CheckboxListTile(
                  value: _liqueur,
                  title: Text('リキュール'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _liqueur = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _cocktail,
                  title: Text('カクテル'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _cocktail = value;
                    });
                  },
                ),
              ),
            ]),
            Text(
              '価格',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Row(children: <Widget>[
              Container(
                padding: const EdgeInsets.all(30),
                child: Text(
                  'Min',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
              ),
              DropdownButton(
                items: _minitems,
                value: _minselectItem,
                onChanged: (value) => {
                  setState(() {
                    _minselectItem = value;
                  }),
                },
              ),
              Text(
                '円　～　Max　',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              DropdownButton(
                items: _maxitems,
                value: _maxselectItem,
                onChanged: (value) => {
                  setState(() {
                    _maxselectItem = value;
                  }),
                },
              ),
              Text(
                '円',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ]),
            Text(
              'おつまみのカテゴリー',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: CheckboxListTile(
                  value: _meat,
                  title: Text('肉'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _meat = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _fish,
                  title: Text('魚'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _fish = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _sweet,
                  title: Text('甘い'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _sweet = value;
                    });
                  },
                ),
              ),
            ]),
            Row(children: <Widget>[
              Expanded(
                child: CheckboxListTile(
                  value: _salty,
                  title: Text('しょっぱい'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _salty = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _easy,
                  title: Text('簡単'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _easy = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _snack,
                  title: Text('スナック'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _snack = value;
                    });
                  },
                ),
              ),
            ]),
            Row(children: <Widget>[
              Expanded(
                child: CheckboxListTile(
                  value: _novelty,
                  title: Text('変わり種'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _novelty = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  value: _party,
                  title: Text('パーティ'),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool value) {
                    setState(() {
                      _party = value;
                    });
                  },
                ),
              ),
            ]),
            Container(
              child: RaisedButton(
                onPressed: () => {
                  Navigator.pop(context) // 呼び出し元に戻る
                  //検索条件を保持してデータベースから探して呼び出し元の画面にて表示
                },
                child: Text('完了'),
              ),
            ),
          ]),
        ));
  }
}

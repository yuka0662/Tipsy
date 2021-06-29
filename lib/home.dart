import 'package:flutter/material.dart';
import './Top.dart';
import './Color.dart';

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
  Choice('サワー', Sour()),
  Choice('ウイスキー', Whisky()),
  Choice('焼酎', Shochu()),
  Choice('リキュール', Liqueur()),
  Choice('カクテル', Cocktail()),
  Choice('おつまみ', Snacks()),
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

class Beer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('ビール一覧表示！！'),
        )
      ],
    );
  }
}

class Sake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('日本酒一覧表示！！'),
        )
      ],
    );
  }
}

class Wine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('ワイン一覧表示！！'),
        )
      ],
    );
  }
}

class Sour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('サワー一覧表示！！'),
        )
      ],
    );
  }
}

class Whisky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('ウイスキー一覧表示！！'),
        )
      ],
    );
  }
}

class Shochu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('焼酎一覧表示！！'),
        )
      ],
    );
  }
}

class Liqueur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Text('リキュール一覧表示！！'),
        )
      ],
    );
  }
}

class Cocktail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
          child: Text(
            'ベース選択',
            style: TextStyle(
              fontSize: 18.0,
              letterSpacing: 5.0,
            ),
          ),
        ),
        for (var $i = 0; $i < 2; $i++)
          Row(children: <Widget>[
            for (var $i = 0; $i < 2; $i++)
              Container(
                padding: const EdgeInsets.all(20),
                height: 150,
                child: RaisedButton(
                  child: const Text(
                    '',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 5.0,
                    ),
                  ),
                  color: Colors.blueAccent,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.blueGrey,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
          ]),
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 20.0),
            child: Text(
              '全体ランキング　TOP10',
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 5.0,
              ),
            ),
          )
        ]),
        for (var $i = 0; $i < 5; $i++)
          Row(children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 10.0),
              child: Text(
                '1.カシスオレンジ',
                style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                ),
              ),
            )
          ]),
      ],
    );
  }
}

class Snacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
          child: Text(
            'ジャンル選択',
            style: TextStyle(
              fontSize: 18.0,
              letterSpacing: 5.0,
            ),
          ),
        ),
        for (var $i = 0; $i < 2; $i++)
          Row(children: <Widget>[
            for (var $i = 0; $i < 2; $i++)
              Container(
                padding: const EdgeInsets.all(20),
                height: 150,
                child: RaisedButton(
                  child: const Text(
                    '',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 5.0,
                    ),
                  ),
                  color: Colors.blueAccent,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.blueGrey,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
          ]),
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 20.0),
            child: Text(
              '全体ランキング　TOP10',
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 5.0,
              ),
            ),
          )
        ]),
        for (var $i = 0; $i < 5; $i++)
          Row(children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 10.0),
              child: Text(
                '1.からあげ',
                style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                ),
              ),
            )
          ]),
      ],
    );
  }
}

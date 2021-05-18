import 'package:flutter/material.dart';

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

class ChoiceCard extends StatefulWidget{
  @override
  _ChoiceCardState createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar:TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blueAccent,
          isScrollable: true,
          tabs: choices.map((Choice choice) {
            return Tab(
              text:choice.label,
            );
          }).toList(),
        ),
        body: TabBarView(children: choices.map((tab) => tab.widget).toList()),
      ),
    );
  }
}

class Beer extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('ビール一覧表示！！'),
        )
      ],
    );
  }
}

class Sake extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('日本酒一覧表示！！'),
        )
      ],
    );
  }
}

class Wine extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('ワイン一覧表示！！'),
        )
      ],
    );
  }
}

class Sour extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('サワー一覧表示！！'),
        )
      ],
    );
  }
}

class Whisky extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('ウイスキー一覧表示！！'),
        )
      ],
    );
  }
}

class Shochu extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('焼酎一覧表示！！'),
        )
      ],
    );
  }
}

class Liqueur extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('リキュール一覧表示！！'),
        )
      ],
    );
  }
}

class Cocktail extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('カクテル一覧表示！！'),
        )
      ],
    );
  }
}

class Snacks extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          child: Text('おつまみ一覧表示！！'),
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          body:TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.blueAccent,
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text:choice.title,
                );
              }).toList(),
            ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'ビール'),
  const Choice(title: '日本酒'),
  const Choice(title: 'ワイン'),
  const Choice(title: 'サワー'),
  const Choice(title: 'ウイスキー'),
  const Choice(title: '焼酎'),
  const Choice(title: 'リキュール'),
  const Choice(title: 'カクテル'),
  const Choice(title: 'おつまみ'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
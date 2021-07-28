import 'package:flutter/material.dart';
import './Color.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices2.length,
        child: Scaffold(
          appBar:PreferredSize(
            preferredSize: Size.fromHeight(25.0),
            child: AppBar(
              title: Text('お気に入り',
                style: TextStyle(
                  color: HexColor('212738')
                ),
              ),
              backgroundColor: Colors.grey[50],
              foregroundColor: HexColor('212738'),
              actions: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () => {},
                  backgroundColor: Colors.blue,
                  label: const Text('選択'),
                )
              ],
            ),
          ),
          body: Center(
            child: ChoiceCard2(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Choice2 {
  String label;
  Widget widget;

  Choice2(this.label, this.widget);
}

final List<Choice2> choices2 = [
  Choice2('おつまみ', LikeSnacks()),
  Choice2('カクテル', LikeCocktail()),
  Choice2('お酒', LikeSake()),
];

class ChoiceCard2 extends StatefulWidget {
  @override
  _ChoiceCardState2 createState() => _ChoiceCardState2();
}

class _ChoiceCardState2 extends State<ChoiceCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: HexColor('43AA8B'),
          indicatorColor: HexColor('43AA8B'),
          tabs: choices2.map((Choice2 choice) {
            return Tab(
              text: choice.label,
            );
          }).toList(),
        ),
        body: TabBarView(children: choices2.map((tab) => tab.widget).toList()),
      ),
    );
  }
}

class LikeSnacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('bases').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['cac_id']),
                  subtitle: new Text(document['cacbase']),
                );
              }).toList(),
            );
        }
      }
    );
  }
}

class LikeCocktail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: Text('お気に入りのカクテル一覧表示！！'),
        )
      ],
    );
  }
}

class LikeSake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: Text('お気に入りのお酒一覧表示！！'),
        )
      ],
    );
  }
}
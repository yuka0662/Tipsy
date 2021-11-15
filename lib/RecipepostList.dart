import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './Color.dart';
import './Newpost.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class RecipepostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('レシピ投稿一覧'),
        backgroundColor: HexColor('212738'),
      ),
      body: DefaultTabController(
        length: choices2.length,
        child: Center(
          child: ChoiceCard2(),
        ),
      ),
    );
  }
}

class Choice2 {
  String label;
  Widget widget;

  Choice2(this.label, this.widget);
}

final List<Choice2> choices2 = [
  Choice2('おつまみ', PostSnacks()),
  Choice2('カクテル', PostCocktail()),
  Choice2('お酒', PostAlcohol()),
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
        body: TabBarView(
          children: choices2.map((tab) => tab.widget).toList(),
        ),
      ),
    );
  }
}

class PostCocktail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                child: const Text('編集'),
                value: '編集',
              ),
              new PopupMenuItem<String>(
                child: const Text('削除'),
                value: '削除',
              )
            ]);
    return ListView(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.grey),
            ),
          ),
          child: ListTile(
            leading: _ImageItem("fauchon_straight"),
            title: Text('紅茶のリキュール　-お湯割り-'),
            trailing: button,
          ),
        ),
        Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.grey),
            ),
          ),
          child: ListTile(
            leading: _ImageItem("fauchon_apple"),
            title: Text("アップルティーのリキュール -お湯割り-"),
            trailing: button,
          ),
        ),
      ],
    );
  }
}

class PostSnacks extends StatelessWidget {
  // final _menuKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
        // key: _menuKey,
        itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                child: const Text('編集'),
                value: '編集',
              ),
              new PopupMenuItem<String>(
                child: const Text('削除'),
                value: '削除',
              )
            ]);
    return ListView(
      children: <Widget>[
        Container(
          // height: 200,
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.grey),
            ),
          ),
          child: ListTile(
            leading: _ImageItem("karaage"),
            title: Text('唐揚げ'),
            trailing: button,
          ),
        ),
        Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.grey),
            ),
          ),
          child: Flexible(
            child: ListTile(
              leading: _ImageItem("fauchon_apple"),
              title: Text("アップルティーのリキュール -お湯割り-"),
              trailing: button,
            ),
          ),
        ),
      ],
    );
  }
}

class PostAlcohol extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final button = new PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuItem<String>>
      [
        new PopupMenuItem<String>
        (
          child: const Text('編集'),
          value: '編集',
          
        ),
        new PopupMenuItem<String>
        (
          child: const Text('削除'),
          value: '削除',
        )
      ]
    );
    return ListView(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.grey),
            ),
          ),
          child: ListTile(
            leading: _ImageItem("fauchon_straight"),
            title: Text('紅茶のリキュール　-お湯割り-'),
            trailing: button,
          ),
        ),
        Container(
          decoration: new BoxDecoration(
            border: new Border(
              bottom: new BorderSide(color: Colors.grey),
            ),
          ),
          child: ListTile(
            leading: _ImageItem("fauchon_apple"),
            title: Text("アップルティーのリキュール -お湯割り-"),
            trailing: button,
          ),
        ),
      ],
    );
  }
}

class _ImageItem extends StatelessWidget
{
  final String name;
  _ImageItem(this.name);
  Widget build(BuildContext context){
    var imageItem = "images/" + name + ".jpg";
    return Container(
      height: 100,
      child: Image.asset(
        imageItem,
        fit: BoxFit.cover,
      ),
    );
  }
}

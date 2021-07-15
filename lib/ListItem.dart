import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class ListItem {
  final int id;
  final TextEditingController controller;
  final String text;

  ListItem({
    @required this.id,
    @required this.text,
    @required this.controller,
  });

  factory ListItem.create(String text) {
    return ListItem(
      id: Random().nextInt(99999),
      text: text,
      controller: TextEditingController(text: text),
    );
  }

  ListItem change(String text) {
    return ListItem(id: this.id, text: text, controller: this.controller);
  }

  void dispose() {
    controller.dispose();
  }

  @override
  String toString() {
    return text;
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ListItem> items = [];

  @override
  void dispose() {
    items.forEach((element) {
      element.dispose();
    });

    super.dispose();
  }

  void add() {
    setState(() {
      items.add(ListItem.create(""));
    });
  }

  void remove(int id) {
    final removedItem = items.firstWhere((element) => element.id == id);
    setState(() {
      items.removeWhere((element) => element.id == id);
    });

    // itemのcontrollerをすぐdisposeすると怒られるので
    // 少し時間をおいてからdipose()
    Future.delayed(Duration(seconds: 1)).then((value) {
      removedItem.dispose();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: ListView(
          children: [
            Text(items.toString()),
            ...items.map((item) => textFieldItem(item)),
            RaisedButton(
              onPressed: () {
                add();
              },
              child: Text("追加"),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFieldItem(
    ListItem item,
  ) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: item.controller,
            onChanged: (text) {
              setState(() {
                items = items
                    .map((e) => e.id == item.id ? item.change(text) : e)
                    .toList();
              });
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            remove(item.id);
          },
        )
      ],
    );
  }
}

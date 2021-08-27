//import 'dart:html';
import 'dart:async';

import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import './Color.dart';
import './Search.dart';
import './home.dart';
//import 'dart:math';

class RecipepostList extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar(
        title: Text('レシピ投稿一覧'),
        backgroundColor: HexColor('212738'),
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()))
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body:
        ListView(
          children: <Widget>[
            Container
            (
               decoration: new BoxDecoration
              (
                  border: new Border(bottom: new BorderSide(color: Colors.grey),),
              ),
              child:
                ListTile
                (
                  leading: _ImageItem("fauchon_straight"),
                  title: Text('紅茶のリキュール　-お湯割り-')
                ),
            ),
            Container
            (
              decoration: new BoxDecoration
              (
                  border: new Border(bottom: new BorderSide(color: Colors.grey),),
              ),
              child:
                ListTile
                (
                  leading: _ImageItem("fauchon_apple"),
                  title: Text("アップルティーのリキュール -お湯割り-"),
                ),
            ),
          ],
        )
    );
  }

  Widget _ImageItem(String name)
  {
    var imageItem = "images/" + name + ".jpg";
    return Container
    (
      height: 100,
      child: Image.asset(imageItem, fit: BoxFit.cover,),
    );
  }
}

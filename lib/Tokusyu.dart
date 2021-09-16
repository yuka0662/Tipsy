import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import './Color.dart';
import 'package:url_launcher/url_launcher.dart';

//ビール
class Beer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _List(100324);
  }
}

//日本酒
class Sake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _List(110662);
  }
}

//ワイン
class Wine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _List(100317);
  }
}

//ウイスキー
class Whisky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _List(100330);
  }
}

//焼酎
class Shochu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _List(110662);
  }
}

//リキュール
class Liqueur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _List(110609);
  }
}

//表示するレイアウト(まとめたもの)
class _List extends StatefulWidget {
  _List(this._code);
  final int _code;

  @override
  _ListState createState() => new _ListState(_code);
}

class _ListState extends State<_List> {
  _ListState(this._code);
  final int _code;

  Map data;
  List useData;

  Future getData() async {
    var response = await http.get(Uri.parse(
        'https://app.rakuten.co.jp/services/api/IchibaItem/Search/20170706?format=json&genreId=' +
            _code.toString() +
            '&hits=10&applicationId=1037189794186643206'));
    if (response.statusCode == 200) {
      data = json.decode(response.body); //json->Mapオブジェクトに格納
      setState(() {
        //状態が変化した場合によばれる
        useData = data["Items"]; //Map->Listに必要な情報だけ格納
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future main() async {
    await getData();
  }

  @override
  void initState() {
    super.initState();
    main();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
      //スクロール可能な可変リストを作る
      itemCount: useData == null ? 0 : useData.length, //受け取る数の定義
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskDetail(
                        useData[index]["Item"]["mediumImageUrls"][0]
                            ["imageUrl"],
                        useData[index]["Item"]["itemName"],
                        useData[index]["Item"]["itemPrice"],
                        useData[index]["Item"]["itemUrl"],
                        useData[index]["Item"]["itemCaption"])));
          },
          child: Card(
            //cardデザインを定義:material_design
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                  width: 150,
                  height: 150,
                  imageUrl: useData[index]["Item"]["mediumImageUrls"][0]
                      ["imageUrl"],
                  errorWidget: (conte, url, dynamic error) =>
                      Image.asset('assets/InPreparation_sp.png'),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          useData[index]["Item"]["itemName"],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Center(
                        child: Text(
                          NumberFormat()
                                  .format(useData[index]["Item"]["itemPrice"])
                                  .toString() +
                              '円',
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TaskDetail extends StatefulWidget {
  TaskDetail(this._image, this._name, this._price, this._url, this._item);
  final String _image;
  final String _name;
  final int _price;
  final String _url;
  final String _item;

  @override
  _TaskDetailState createState() =>
      _TaskDetailState(_image, _name, _price, _url, _item);
}

class _TaskDetailState extends State {
  _TaskDetailState(this._image, this._name, this._price, this._url, this._item);
  final String _image;
  final String _name;
  final int _price;
  final String _url;
  final String _item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: ListView(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                height: 170,
                imageUrl: _image,
                fit: BoxFit.fitHeight,
                errorWidget: (conte, url, dynamic error) =>
                    Image.asset('assets/InPreparation_sp.png'),
              ),
              Flexible(
                child: Text(_name + '\n',
                    style: TextStyle(
                        fontSize: 15.0,
                        letterSpacing: 5.0,
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                NumberFormat().format(_price).toString() + '円\n',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          ListTile(
            title: Container(
              color: HexColor('212738'),
              margin: EdgeInsets.fromLTRB(180, 0, 0, 0),
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                '購入ページに移動',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            onTap: () {
              launch(_url);
            },
          ),
          Text('\n商品説明\n',
              style: TextStyle(
                  fontSize: 20.0,
                  letterSpacing: 5.0,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal)),
          Text(_item + '\n\n\n\n',
              style: TextStyle(
                  fontSize: 15.0,
                  letterSpacing: 5.0,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }
}

//import 'dart:html';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tipsy/Liquor.dart';
import 'package:tipsy/Timer.dart';
import 'API/osakeAPI.dart';
import 'Home.dart';

//表示するレイアウト(まとめたもの)
class Top extends StatefulWidget {
  @override
  _TopState createState() => new _TopState();
}

class _TopState extends State {
  final List images = [
    "images/appicon.png",
    "images/logo.png",
    "images/karaage.png"
  ];

  Map data;
  List useData;

  Future getData() async {
    var response = await http.get(Uri.parse(
        'https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20170628?genreId=510915&page=1&applicationId=1037189794186643206'));
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
    return ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 15),
        child: GestureDetector(
          onTap: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Liquor()))
          },
          child: Image.asset(
            './images/tokusyu_2.png',
          ),
        ),
      ),
      /*Flexible(
          child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TimerApp()))
        },
        child: Image.asset('./images/tokusyu_1.png'),
      )),*/
      Flexible(
          child: Text(
        '人気のお酒ランキング',
        style: TextStyle(fontSize: 20, wordSpacing: 20),
      )),
      Flexible(
        child: Container(
            height: 500,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              //スクロール可能な可変リストを作る
              itemCount: useData == null ? 0 : 10, //受け取る数の定義
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
                                int.parse(useData[index]["Item"]["itemPrice"]),
                                useData[index]["Item"]["itemUrl"],
                                useData[index]["Item"]["itemCaption"])));
                  },
                  child: Card(
                    //cardデザインを定義:material_design
                    child: Row(
                      children: <Widget>[
                        Text('第' + (index + 1).toString() + '位'),
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
                                          .format(int.parse(useData[index]
                                              ["Item"]["itemPrice"]))
                                          .toString() +
                                      '円',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 17),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
                //Row(children: [child:],),
              },
            )),
      ),
    ]);
  }
}

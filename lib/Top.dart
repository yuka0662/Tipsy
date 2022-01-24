import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './API/snacksAPI.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'API/osakeAPI.dart';
import 'Color.dart';

//表示するレイアウト(まとめたもの)
class Top extends StatefulWidget {
  @override
  _TopState createState() => new _TopState();
}

class _TopState extends State {
  List images = [
    "images/top/tokusyu_1.png",
    "images/top/tokusyu_2.png",
    "images/top/tokusyu_3.jpg",
  ];
  List siteURL = [
    "https://www.kairindo.jp/SHOP/286282/list.html",
    "https://www.furusato-tax.jp/contents/craftbeer",
    "https://www.enoteca.co.jp/archives/detail/BJ",
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

  List snackData;
  List docs;
  Future getSnackData() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('snacks').snapshots()) {
      snackData = [];
      docs = [];
      for (var snack in snapshot.docs) {
        setState(() {
          snackData.add(snack.data());
          docs.add(snack.id);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    getSnackData();
  }

  @override
  Widget build(BuildContext context) {
    if (snackData == null) {
      return Scaffold(
        body: Text(''),
      );
    } else {
      return ListView(children: <Widget>[
        CarouselSlider.builder(
          options: CarouselOptions(
            initialPage: 0,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            autoPlay: true,
          ),
          itemCount: images == null ? 0 : 3,
          itemBuilder: (BuildContext context, int index, int index2) {
            return GestureDetector(
                onTap: () => {
                      launch(siteURL[index]),
                    },
                child: Image.asset(images[index]));
          },
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Flexible(
              child: Text(
            'おすすめのおつまみ',
            style: TextStyle(
                fontSize: 20, color: HexColor('212738'), wordSpacing: 20),
          )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 210,
              initialPage: 0,
              viewportFraction: 0.5,
              enableInfiniteScroll: true,
              autoPlay: false,
            ),
            itemCount: snackData == null ? 0 : snackData.length,
            itemBuilder: (BuildContext context, int index, int index2) {
              return GestureDetector(
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrecipeDetail(index, docs[index]),
                          ),
                        ),
                      },
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        height: 150,
                        imageUrl: snackData[index]['image'],
                        errorWidget: (conte, url, dynamic error) =>
                            Image.asset('assets/InPreparation_sp.png'),
                      ),
                      Text(
                        snackData[index]['name'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ));
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Flexible(
              child: Text(
            '人気のお酒ランキング',
            style: TextStyle(
                fontSize: 20, color: HexColor('212738'), wordSpacing: 20),
          )),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Flexible(
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
                                    int.parse(
                                        useData[index]["Item"]["itemPrice"]),
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
                              imageUrl: useData[index]["Item"]
                                  ["mediumImageUrls"][0]["imageUrl"],
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
                  },
                )),
          ),
        ),
      ]);
    }
  }
}
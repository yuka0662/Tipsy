import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import 'dart:async';
import 'dart:convert';
import '../home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//カクテル一覧表示
class CocktailsAll extends StatefulWidget {
  CocktailsAll(this._base);
  final String _base;

  @override
  _CocktailAllState createState() => new _CocktailAllState(_base);
}

class _CocktailAllState extends State<CocktailsAll> {
  _CocktailAllState(this._base);
  final String _base;
  var base = '';
  var technique = '';
  var taste = '';
  var style = '';
  var top = '';

  final _saved = Set();

  Map data;
  List useData;

  Future getData() async {
    if (_base == 'ジン') {
      base = '1';
    } else if (_base == 'ウォッカ') {
      base = '2';
    } else if (_base == 'テキーラ') {
      base = '3';
    } else if (_base == 'ラム') {
      base = '4';
    } else if (_base == 'ウィスキー') {
      base = '5';
    } else if (_base == 'ブランデー') {
      base = '6';
    } else if (_base == 'リキュール') {
      base = '7';
    } else if (_base == 'ワイン') {
      base = '8';
    } else if (_base == 'ビール') {
      base = '9';
    } else if (_base == '日本酒') {
      base = '10';
    } else if (_base == 'ノンアルコール') {
      base = '0';
    } else if (_base == 'ビルド') {
      technique = '1';
    } else if (_base == 'ステア') {
      technique = '2';
    } else if (_base == 'シェイク') {
      technique = '3';
    } else if (_base == '甘口') {
      taste = '1';
    } else if (_base == '中甘口') {
      taste = '2';
    } else if (_base == '中口') {
      taste = '3';
    } else if (_base == '中辛口') {
      taste = '4';
    } else if (_base == '辛口') {
      taste = '5';
    } else if (_base == 'ショート') {
      style = '1';
    } else if (_base == 'ロング') {
      style = '2';
    } else if (_base == '食前') {
      top = '1';
    } else if (_base == '食後') {
      top = '2';
    } else if (_base == 'オール') {
      top = '3';
    }

    var response = await http.get(Uri.parse(
        'https://cocktail-f.com/api/v1/cocktails?base=' +
            base +
            '&technique=' +
            technique +
            '&taste=' +
            taste +
            '&style=' +
            style +
            '&top=' +
            top +
            '&limit=10'));
    if (response.statusCode == 200) {
      data = json.decode(response.body); //json->Mapオブジェクトに格納
      setState(() {
        //状態が変化した場合によばれる
        useData = data["cocktails"]; //Map->Listに必要な情報だけ格納
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
      //スクロール可能な可変リストを作る
      itemCount: useData == null ? 0 : useData.length, //受け取る数の定義
      itemBuilder: (BuildContext context, int index) {
        final alreadySaved = _saved.contains(index);
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipeDetail(
                        useData[index]["cocktail_id"],
                        useData[index]["cocktail_name"],
                        useData[index]["cocktail_name_english"],
                        useData[index]["base_name"]==null?'なし':useData[index]["base_name"],
                        useData[index]["technique_name"],
                        useData[index]["taste_name"],
                        useData[index]["style_name"],
                        useData[index]["alcohol"].toString(),
                        useData[index]["top_name"],
                        useData[index]["glass_name"],
                        useData[index]["cocktail_digest"],
                        useData[index]["cocktail_desc"],
                        useData[index]["recipe_desc"],
                        useData[index]["recipes"],
                        AuthModel().user.email)));
          },
          child: Card(
            //cardデザインを定義:material_design
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                  width: 150,
                  height: 150,
                  imageUrl:
                      'https://dm58o2i5oqos8.cloudfront.net/photos/${useData[index]["cocktail_id"]}.jpg',
                  errorWidget: (conte, url, dynamic error) =>
                      Image.asset('assets/InPreparation_sp.png'),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          useData[index]["cocktail_digest"],
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Center(
                        child: Text(
                          useData[index]["cocktail_name"],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      try {
                        final docRef = FirebaseFirestore.instance
                            .collection('favorites')
                            .doc(AuthModel().user.email)
                            .collection('カクテル')
                            .doc(useData[index]["cocktail_id"].toString());
                        final docSnapshot =
                            await docRef.get(); // DocumentSnapshot
                        final data =
                            docSnapshot.exists ? docSnapshot.data() : null;
                        //alreadySaved =
                        if (alreadySaved) {
                          await FirebaseFirestore.instance
                              .collection('favorites')
                              .doc(AuthModel().user.email)
                              .collection('カクテル')
                              .doc(useData[index]["cocktail_id"].toString())
                              .update({
                            'state': 'false',
                            'id': useData[index]["cocktail_id"]
                          });
                          setState(() {
                            _saved.remove(index);
                          });
                        } else {
                          await FirebaseFirestore.instance
                              .collection('favorites')
                              .doc(AuthModel().user.email)
                              .collection('カクテル')
                              .doc(useData[index]["cocktail_id"].toString())
                              .set({
                            'state': 'true',
                            'id': useData[index]["cocktail_id"]
                          });
                          setState(() {
                            _saved.add(index);
                          });
                        }

                        print(alreadySaved);
                      } catch (e) {
                        print("${e.toString()}");
                      }
                    },
                    icon: alreadySaved
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          )),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '../home.dart';

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
  var base;

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
    } else {
      base = '0';
    }

    var response = await http.get(Uri.parse(
        'https://cocktail-f.com/api/v1/cocktails?word=' '&base=' +
            base +
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
      //スクロール可能な可変リストを作る
      itemCount: useData == null ? 0 : useData.length, //受け取る数の定義
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecipeDetail(useData[index]["cocktail_id"], useData[index]["cocktail_name"],useData[index]["cocktail_name_english"],useData[index]["base_name"],useData[index]["technique_name"],useData[index]["taste_name"],useData[index]["style_name"],useData[index]["alcohol"].toString(),useData[index]["top_name"],useData[index]["glass_name"],useData[index]["cocktail_digest"],useData[index]["cocktail_desc"],useData[index]["recipe_desc"],useData[index]["recipes"])));
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

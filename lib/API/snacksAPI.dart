import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

//おつまみ一覧表示
class SnacksAll extends StatefulWidget {
  SnacksAll(this._category);
  final String _category;

  @override
  _SnackState createState() => new _SnackState(_category);
}

class _SnackState extends State<SnacksAll> {
  _SnackState(this._category);
  final String _category;
  var category;

  Map data;
  List useData;

  Future getData() async {
    
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
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrecipeDetail()));
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
                  onPressed: () => {},
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.black,
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

//おつまみ作り方表示ページ
class OrecipeDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Text('だし巻き卵\n\n調理時間：15分\nきれいな仕上がり◎おかずにぴったりなだし巻き卵♪\n',
          style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text('材料(4人分)',
          style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text(
          '卵　　　　　　　　　　　　：4個\nⒶ水　　　　　　　　　　　：大さじ6\nⒶ「ほんだし」　　　　　　：小さじ1/2\nⒶみりん　　　　　　　　　：小さじ2\nⒶ薄口しょうゆ　　　　　　：小さじ1\n「AJINOMOTO サラダ油」：適量\n大根おろし・お好みで　　　：適量\n',
          style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text('手順',
          style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text(
          '1. ボウルに卵を割りほぐし、白身を切るようによく溶く。混ぜ合わせたＡを加えてさらに混ぜる。\n\n2. 卵焼き器を強めの中火で熱し、油を含ませたキッチンペーパーで全体に油をなじませる。（１）の卵液を玉じゃくし七分目ほど入れて広げ、半熟になったら向こう側から手前に向かって巻き、巻いた卵を向こう側に送る。\n\n3. 卵焼き器に油をなじませ、再び卵液を流し入れる。巻いた卵を持ち上げて下に卵液を流し、卵のフチが固まってきたら手前に巻き込む。同様にくり返し焼く。\n\n4. 焼き上がったらまな板に取り出し、粗熱が取れたら食べやすい大きさに切る。\n\n5. 器に盛り、好みで大根おろしを添える。\n',
          style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text('メモ',
          style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text('コツ・ポイント\n＊お弁当に入れる際は、Ａに塩少々を加えてください。',
          style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
    ]);
  }
}
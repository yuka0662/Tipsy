import 'package:flutter/material.dart';
import './Top.dart';
import './Color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Home());

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          body: Center(
            child: ChoiceCard(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Choice {
  String label;
  Widget widget;

  Choice(this.label, this.widget);
}

final List<Choice> choices = [
  Choice('ホーム', Top()),
  Choice('ビール', Beer()),
  Choice('日本酒', Sake()),
  Choice('ワイン', Wine()),
  Choice('ウイスキー', Whisky()),
  Choice('焼酎', Shochu()),
  Choice('リキュール', Liqueur()),
  Choice('カクテル', Cocktail()),
  Choice('おつまみ', Snacks()),
];

class ChoiceCard extends StatefulWidget {
  @override
  _ChoiceCardState createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: HexColor('43AA8B'),
          indicatorColor: HexColor('43AA8B'),
          isScrollable: true,
          tabs: choices.map((Choice choice) {
            return Tab(
              text: choice.label,
            );
          }).toList(),
        ),
        body: TabBarView(children: choices.map((tab) => tab.widget).toList()),
      ),
    );
  }
}

class Beer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        new ListTile(
          title: Text('アサヒスーパードライ'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TaskDetail()));
          },
        )
      ],
    );
    /*StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('alcohols')
          //.orderBy('', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Text('Loading...');
          default:
            return ListView(
              children:
                  snapshot.data.docs.map((DocumentSnapshot document) {
                return new ListTile(
                  title: Text(document['alc_id']),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TaskDetail(document['id'])));
                    },
                );
              }).toList(),
            );
        }
      },
    );
    */
  }
}

class Sake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        new ListTile(
          title: Text('くどき上手'),
          onTap: () {},
        )
      ],
    );
  }
}

class Wine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        new ListTile(
          title: Text('塩尻メルロ ロゼ 2019'),
          onTap: () {},
        )
      ],
    );
  }
}

class Whisky extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        new ListTile(
          title: Text('ブラックニッカ クリア'),
          onTap: () {},
        )
      ],
    );
  }
}

class Shochu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        new ListTile(
          title: Text('麦焼酎　あんぽんたん'),
          onTap: () {},
        )
      ],
    );
  }
}

class Liqueur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        new ListTile(
          title: Text('カルーアリキュール'),
          onTap: () {},
        )
      ],
    );
  }
}

class Cocktail extends StatelessWidget {
  var category = ['甘口','辛口','軽い','重い'];
  var array = [
    'アル・カポネ',
    'オーロラ',
    'クールビューティ－～清涼美～',
    'サザン・ウインド～南国からの便り～',
    'ドラマティック・アロマ'
  ];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
          child: Text(
            'ベース選択',
            style: TextStyle(
              fontSize: 18.0,
              letterSpacing: 5.0,
            ),
          ),
        ),
        for (var $i = 0; $i < 1; $i++)
          Row(children: <Widget>[
            for (var $i = 0; $i < 3; $i++)
              Container(
                padding: const EdgeInsets.all(20),
                height: 150,
                child: RaisedButton(
                  child: Text(
                    '${category[$i]}',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 5.0,
                    ),
                  ),
                  color: Colors.blueAccent,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.blueGrey,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
          ]),
        /*
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('cacktails').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new RichText(
                      text: TextSpan(
                    style: TextStyle(color: Colors.blue),
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return new TextSpan(
                        text: document['cacbase'],
                        //リンクをつける(要調べ)
                      );
                    }).toList(),
                  ));
              }
            }),
            */
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 20.0),
            child: Text(
              '全体ランキング　TOP10',
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 5.0,
              ),
            ),
          )
        ]),
        for (var $i = 0; $i < 5; $i++)
          Row(children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('${$i + 1}.${array[$i]}',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 5.0,
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RecipeDetail()));
                },
              ),
            )
          ]),
        /*
        StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('c_ranking').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return new Text('Loading...');
                default:
                  return new RichText(
                      text: TextSpan(
                    style: TextStyle(color: Colors.blue),
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return new TextSpan(
                        text: document['crank_id'],
                        //リンクをつける(要調べ)
                      );
                    }).toList(),
                  ));
              }
            }),
            */
      ],
    );
  }
}

class Snacks extends StatelessWidget {
  var category = ['簡単','お手軽','肉','魚'];
  var array = ['だし巻き卵','あさりの酒蒸し','きゅうりと大根の漬物','簡単ポテトサラダ','枝豆の塩ゆで'];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 0),
          child: Text(
            'ジャンル選択',
            style: TextStyle(
              fontSize: 18.0,
              letterSpacing: 5.0,
            ),
          ),
        ),
        for (var $i = 0; $i < 1; $i++)
          Row(children: <Widget>[
            for (var $j = 0; $j < 3; $j++)
              Container(
                padding: const EdgeInsets.all(20),
                height: 150,
                child: RaisedButton(
                  child: Text(
                    '${category[$j]}',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 5.0,
                    ),
                  ),
                  color: Colors.blueAccent,
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Colors.blueGrey,
                      width: 1,
                      style: BorderStyle.solid,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
          ]),
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 0, 20.0),
            child: Text(
              '全体ランキング　TOP10',
              style: TextStyle(
                fontSize: 18.0,
                letterSpacing: 5.0,
              ),
            ),
          )
        ]),
        for (var $i = 0; $i < 5; $i++)
          Row(children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('${$i + 1}.${array[$i]}',
                    style: TextStyle(
                      fontSize: 15.0,
                      letterSpacing: 5.0,
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => OrecipeDetail()));
                },
              ),
            )
          ]),
      ],
    );
  }
}

class TaskDetail extends StatelessWidget {
  //TaskDetail(this.id);
  //String id;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Text('アサヒスーパードライ\n￥2,200\n',
          style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      ListTile(
        title: Text('購入ページへGo!!'),
        onTap: () {
          launch(
              'https://www.amazon.co.jp/%E3%82%B9%E3%83%BC%E3%83%91%E3%83%BC%E3%83%89%E3%83%A9%E3%82%A4-%E3%82%A2%E3%82%B5%E3%83%92-350%EF%BD%8D%EF%BD%8C%E7%BC%B6%C3%9724%E6%9C%AC/dp/B0029ZFYJQ/ref=sr_1_1_sspa?__mk_ja_JP=%E3%82%AB%E3%82%BF%E3%82%AB%E3%83%8A&dchild=1&keywords=%E3%82%A2%E3%82%B5%E3%83%92%E3%82%B9%E3%83%BC%E3%83%91%E3%83%BC%E3%83%89%E3%83%A9%E3%82%A4&qid=1627542075&sr=8-1-spons&psc=1&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUExMkpENTRRMlRCR1JSJmVuY3J5cHRlZElkPUEwNjQwMTMzTkVOVzNDNDJaV1FVJmVuY3J5cHRlZEFkSWQ9QTFMN01XTEdYNjhWRE0md2lkZ2V0TmFtZT1zcF9hdGYmYWN0aW9uPWNsaWNrUmVkaXJlY3QmZG9Ob3RMb2dDbGljaz10cnVl');
        },
      ),
      Text('商品説明',
          style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text('洗練されたクリアな味、辛口。さらりとした口あたり、シャープなのどごし。キレ味さえる、いわば辛口ビールです。',
          style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
    ]);
  }
}

class OrecipeDetail extends StatelessWidget {
  //OrecipeDetail(this.id);
  //String id;

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
      Text('卵　　　　　　　　　　　　：4個\nⒶ水　　　　　　　　　　　：大さじ6\nⒶ「ほんだし」　　　　　　：小さじ1/2\nⒶみりん　　　　　　　　　：小さじ2\nⒶ薄口しょうゆ　　　　　　：小さじ1\n「AJINOMOTO サラダ油」：適量\n大根おろし・お好みで　　　：適量\n',
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
      Text('1. ボウルに卵を割りほぐし、白身を切るようによく溶く。混ぜ合わせたＡを加えてさらに混ぜる。\n\n2. 卵焼き器を強めの中火で熱し、油を含ませたキッチンペーパーで全体に油をなじませる。（１）の卵液を玉じゃくし七分目ほど入れて広げ、半熟になったら向こう側から手前に向かって巻き、巻いた卵を向こう側に送る。\n\n3. 卵焼き器に油をなじませ、再び卵液を流し入れる。巻いた卵を持ち上げて下に卵液を流し、卵のフチが固まってきたら手前に巻き込む。同様にくり返し焼く。\n\n4. 焼き上がったらまな板に取り出し、粗熱が取れたら食べやすい大きさに切る。\n\n5. 器に盛り、好みで大根おろしを添える。\n',
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

class RecipeDetail extends StatelessWidget {
  //RecipeDetail(this.id);
  //String id;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Text('アル・カポネ\n\nカクテルタイプ： ショート\nテイスト　　　： 中甘辛口\nアルコール度数： 強い(25度以上)\n製法　　　　　： シェイク\n',
          style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text('材料',
          style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
      Text('テネシーウイスキー　　：30ml\nクランベリーリキュール：15ml\nディサローノアマレット：15ml\nライムジュース　　　　：1tsp\n',
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
      Text('1. シェークしてカクテルグラスに注ぐ。\n\n2. 野菜・ライムピール・ブラックオリーブでボルサリーノ（帽子）をイメージしたデコレーションを飾る。\n',
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
      Text('コツ・ポイント',
          style: TextStyle(
              fontSize: 15.0,
              letterSpacing: 5.0,
              color: Colors.black,
              decoration: TextDecoration.none)),
    ]);
  }
}

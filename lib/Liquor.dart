import 'package:flutter/material.dart';

class Liquor extends StatefulWidget {
  @override
  Lstate createState() => new Lstate();
}

class Lstate extends State {
  List<String> qlist = [
    'あなた好みのお酒をおすすめします！',
    '普段どれくらいお酒を飲みますか？',
    '普段どんなお酒を飲みますか？',
    '好みの味はどれですか？',
    '苦手なものはどれですか？',
    'どんな時に飲みますか？',
    '好きな料理はどれなんですか？',
    '何と一緒に飲むことが多いですか？',
    '好きなおやつのジャンルは？',
    '重要視しているものは？',
    'どうやって飲む？',
    'あなたにおすすめのお酒は・・・'
  ];

  List<List<String>> alist = [
    ['Start'],
    ['毎日', '週に3－4日', '週に1－2日', '時々'],
    ['醸造酒(日本酒、ビール、ワイン等)', '蒸留酒(焼酎、ウイスキー等)', '混成酒(果実酒、リキュール等)'],
    ['甘め', '苦め', '渋め', 'その他', '特になし'],
    ['炭酸系', '甘い系', '苦味', '渋み', '特になし'],
    ['ごはんを食べながら', 'テレビを見ながら', 'リラックスしながら', '誰かと一緒に'],
    ['肉系', '魚系', '野菜系', '揚げ物'],
    ['おつまみ', 'おやつ', 'スイーツ'],
    ['スナック系', 'チョコ系', 'するめ系'],
    ['色', '香り', '味', '特になし'],
    ['ペースが速め', '味わって飲む', 'ゆっくり飲む'],
    ['リキュールです']
  ];

  var res = 0;
  var _cnt = 0;

  void _getResultIncorrect() {
    setState(() {
      _cnt++;
      res = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('lib/logo/logo.png'),
            Container(
              padding: EdgeInsets.all(20),
              height: 70,
              child: Center(
                child: Text(
                  qlist[_cnt],
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < alist[_cnt].length; i++)
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: RaisedButton(
                            child: Text(alist[_cnt][res + i]),
                            onPressed: _getResultIncorrect,
                          )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

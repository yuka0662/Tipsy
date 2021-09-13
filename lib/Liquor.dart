import 'package:flutter/material.dart';
import 'dart:math';
//import 'package:tipsy/Top.dart';

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
    'どうやって飲む？'
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
    ['ペースが速め', '味わって飲む', 'ゆっくり飲む']
  ];

  var res = 0;
  var _cnt = 0;
  int a = 0;
  int ra = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Image.asset('lib/logo/logo.png'),
            Container(
              height: 70,
              child: Center(
                child: Text(
                  qlist[_cnt],
                  style: TextStyle(fontSize: 30),
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
                              child: Text(alist[_cnt][res + i],
                                  style: TextStyle(fontSize: 25)),
                              onPressed: () {
                                if (_cnt + 1 < qlist.length) {
                                  setState(() {
                                    ra = Random().nextInt(alist[_cnt].length);
                                    a = a + ra;
                                    _cnt++;
                                    res = 0;
                                  });
                                } else {
                                  setState(() {
                                    a = a % 6;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Ans(a),
                                    ),
                                  );
                                }
                              })),
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

class Ans extends StatelessWidget {
  Ans(this._a);
  final int _a;

  List<List<String>> rlist = [
    [
      "あなたは誰とでも仲良くなれる「ビール」タイプ",
      "あなたはビールのように爽やかな人ですね。誰とでも仲良くできるクセのない性格で、居酒屋における「乾杯の一杯」のように、仲間内では欠かせない存在です。あなたのことを苦手に思う人は少ないでしょう。 といっても軽薄なタイプではなく、人生の苦味をちゃんと知っています。重すぎず軽すぎず、とてもバランスのとれた性格をしています。しかし、一歩道を踏み外すと、黒ビールのごとく苦みばしってしまい、アクの強い人になってしまいます。とくに独りぼっちでいるとその傾向が高まるので、恋人や親友といったパートナーを見つけることをおすすめします。 枝豆や焼き鳥のような自分と相性ぴったりの相手を探すことができれば、きっと人生が充実するでしょう。"
    ],
    [
      "あなたは味わい深い「ワイン」タイプ",
      "あなたはワインのような味わい深い人になる可能性を秘めています。しぼったブドウを樽のなかで数年間熟成することでおいしいワインになるように、あなたの人生も熟成するほどに味が出てきます。 ただ、今のあなたはまだ若いワインというか、少し風味に欠けるところがありそうです。どちらかというと大器晩成タイプで、あなたの本当の良さが引き出されるのは、まだ少し時間がかかるかもしれません。 でも大器晩成だからといって、「いま努力しても意味がないや」なんて思わないでください。ワインは管理が悪ければ味が落ちてしまうように、あなたの人生もいい加減に過ごしていると、後味の悪いものになってしまいます。おいしいワインになるためには、地道な努力も必要です。"
    ],
    [
      "あなたは火がつくほど強い「ウォッカ」タイプ",
      "あなたはウォッカのように激しい人ですね。最強クラスのアルコール度数を持つウオッカみたいに、あなたもいったん火がつくと抑えられないようなところがあります。 ただ、無味無臭のウォッカと同様に、あなたの性根は純真で、気持ちの良い性格をしています。日ごろは涼やかな人なのですが、その内面には熱いものを秘めている…そんな感じです。 「ソルティ・ドッグ」や「スクリュー・ドライバー」といったウォッカを使ったカクテルがたくさんありますが、あなたもソルティ・ドッグにおけるグレープフルーツのようなベストパートーナーを見つければ、さらに輝きが増すでしょう。ぜひ自分を引き立ててくれる相手を見つけてくださいね。"
    ],
    [
      "あなたは透明感のある「日本酒」タイプ",
      "あなたは日本酒のように凛とした人ですね。とっても透明感があり、さっぱりとした性格をしています。 まさに竹を割ったような人ですが、真っすぐすぎるせいか、おちゃらけた人からは敬遠されることもあるでしょう。あなたとしては普通にコミュニケーションをとっているつもりでも、「クソ真面目」だの「冗談が通じない」だの言われたことはないでしょうか。 あなたは言わば純米大吟醸のようなものです。米を限界まで削ってつくる純米大吟醸は、雑味がなくすっきりとした味わいです。ただ、あえて米をあまり削らないことで、日本酒としての品質は下がりますが、雑味が良い個性として味にアクセントを与えることもあるのです。あなた自身も、あまり身を削り過ぎず、あえて遊びを残すことで、今よりももっと魅力的になれると思いますよ。"
    ],
    [
      "あなたは原料によって味が変わる「焼酎」タイプ",
      "あなたは焼酎のような人ですね。焼酎といえば、麦焼酎や芋焼酎、黒糖焼酎といったように、原材料によってずいぶん風味が異なります。あなた自身も、周囲の影響を受けやすいタイプで、麦焼酎のようにさっぱりした人になることもあれば、芋焼酎のように少しクセのある人になることもあります。 ただ、麦焼酎が良くて、芋焼酎がダメだと言うわけではありません。芋焼酎は独特な匂いと後味が苦手だという人もいますが、九州では薩摩の人々を中心に多くの人に愛されています。こればかりは相性なので、どちらが良いとは言えません。 ひとつだけ気をつけてほしいのは、環境に影響されやすいということを、心に留めておくことです。自分に悪影響を与えそうな環境からは、意識して距離をとるのがいいかもしれませんね。"
    ],
    [
      "あなたは大人っぽい魅力がある「ウイスキー」タイプ",
      "あなたはウイスキーのように大人な魅力のある人ですね。ウイスキーは芳醇な香りとアルコール度数の高さが魅力的なお酒です。あなたの魅力で皆を惑わせるのが得意なようです。"
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 20)),
        Image.asset('lib/logo/logo.png'),
        Container(
          padding: EdgeInsets.all(20),
          height: 70,
          child: Center(
            child: Text(
              rlist[_a][0],
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        Expanded(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(rlist[_a][1],
                    style: TextStyle(fontSize: 25, letterSpacing: 4.0))))
      ]),
    ));
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Color.dart';
import 'main.dart';

/// 肝ちゃん着せ替え
class DressUp extends StatefulWidget {
  @override
  _DressUpState createState() => _DressUpState();
}

/// タイマーページの状態を管理するクラス
class _DressUpState extends State {
  int point;
  String selectImage = "images/kanchan/kanchan.PNG";
  bool flag = true;

  Future getPoint() async {
    var docRef = FirebaseFirestore.instance
        .collection('timer')
        .doc(AuthModel().user.email);
    docRef.get().then((doc) {
      //if (doc.exists) {
      setState(() {
        point = doc.get('point');
      });
      //}
    });
  }

  /// 初期化処理
  @override
  void initState() {
    super.initState();
    getPoint();
  }

  @override
  Widget build(BuildContext context) {
    //肝ちゃん着せ替えアイテム画像
    var list = [
      _photoItem("k_bikini", "ビキニ" /*,"着せ替え衣装のみの画像"*/),
      _photoItem("k_magician", "マジシャン"),
      _photoItem("k_maid", "メイド服"),
      _photoItem("k_onepiece", "ワンピース"),
      _photoItem("k_ribbon", "頭リボン"),
      _photoItem("k_sailor", "セーラー"),
      _photoItem("k_strawhat", "麦わら帽子"),
      _photoItem("k_suit", "スーツ"),
      _photoItem("k_sunglasses", "サングラス"),
      _photoItem("k_witch", "魔女"),
    ];
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            height: 200,
            child: Image.asset(selectImage),
          ),
        ),
        Text(
          '使えるポイント　${point == null ? 0 : point}pt',
          style: TextStyle(fontSize: 20),
        ),
        Expanded(
          child: GridView.extent(
              maxCrossAxisExtent: 150,
              padding: const EdgeInsets.all(4),
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: list),
        ),
      ],
    ));
  }

  Widget _photoItem(String image, String name /**,String selectimage */) {
    var assetsImage = "images/kanchan/" + image + ".PNG";
    //var dressupImage = "images/kanchan/" + selectImage + ".PNG";
    return GestureDetector(
      onTap: () {
        //tap処理
        flag == false
            ? showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(name),
                    content: Container(
                      height: 250,
                      child: Column(
                        children: [
                          Image.asset(
                            assetsImage /**dressupImage */,
                          ),
                          Text("500pt使って購入しますか？"),
                        ],
                      ),
                    ),
                    actions: [
                      SimpleDialogOption(
                        child: Text('はい'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SimpleDialogOption(
                        child: Text('いいえ'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                })
            : setState(() {
                selectImage = assetsImage;
              });
      },
      child: Image.asset(
        assetsImage /**dressupImage */,
        fit: BoxFit.cover,
      ),
    );
  }
}

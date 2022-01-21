import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  var emessage = 'ポイントが足りません';
  List flags;
  var executed;

  Future getKanchan() async {
    var docRef = FirebaseFirestore.instance
        .collection('kanchan')
        .doc(AuthModel().user.email);
    docRef.get().then((doc) {
      //if (doc.exists) {
      setState(() {
        selectImage = doc.get('dress');
      });
      //}
    });
  }

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

  Future setBuyFlag(int id) async {
    var data = {
      'flag': false,
    };
    await FirebaseFirestore.instance
        .collection('buy_flag')
        .doc(AuthModel().user.email)
        .collection('flag')
        .doc(id.toString())
        .set(data);
  }

  Future getBuyFlag() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('buy_flag')
        .doc(AuthModel().user.email)
        .collection('flag')
        .snapshots()) {
      flags = [];
      for (var flag in snapshot.docs) {
        setState(() {
          flags.add(flag.data());
        });
      }
      executed = flags.contains(true);
    }
  }

  /// 初期化処理
  @override
  void initState() {
    super.initState();
    getPoint();
    getKanchan();
    getBuyFlag();
    if (executed == false) {
      for (int i = 0; i < 10; i++) {
        setBuyFlag(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (flags != null) {
      //肝ちゃん着せ替えアイテム画像
      var list = [
        _photoItem("k_bikini", "ビキニ", "bikini", flags[0]['flag'], 0, 50),
        _photoItem("k_magician", "マジシャン", "magician", flags[1]['flag'], 1, 75),
        _photoItem("k_maid", "メイド服", "maid", flags[2]['flag'], 2, 100),
        _photoItem("k_onepiece", "ワンピース", "onepiece", flags[3]['flag'], 3, 125),
        _photoItem("k_ribbon", "頭リボン", "ribbon", flags[4]['flag'], 4, 150),
        _photoItem("k_sailor", "セーラー", "sailor", flags[5]['flag'], 5, 175),
        _photoItem("k_strawhat", "麦わら帽子", "strawhat", flags[6]['flag'], 6, 200),
        _photoItem("k_suit", "スーツ", "suit", flags[7]['flag'], 7, 225),
        _photoItem(
            "k_sunglasses", "サングラス", "sunglasses", flags[8]['flag'], 8, 250),
        _photoItem("k_witch", "魔女", "witch", flags[9]['flag'], 9, 300),
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
    } else {
      return Scaffold(
        body: Text(''),
      );
    }
  }

  Widget _photoItem(String image, String name, String selectimage, bool flag,
      int id, int needpoint) {
    var assetsImage = "images/kanchan/" + image + ".PNG";
    var dressupImage = "images/dress/" + selectimage + ".PNG";
    return GestureDetector(
      onTap: () async {
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
                          Container(
                            height: 200,
                            child: Image.asset(
                              dressupImage,
                            ),
                          ),
                          Text("${needpoint}pt使って購入しますか？"),
                          Text(
                            (point == null ? 0 : point) >= needpoint
                                ? ''
                                : emessage,
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      SimpleDialogOption(
                        child: Text('はい'),
                        onPressed: () async {
                          if (point >= needpoint) {
                            await FirebaseFirestore.instance
                                .collection('timer')
                                .doc(AuthModel().user.email)
                                .update({'point': point - needpoint});
                            var data = {
                              'flag': true,
                            };
                            await FirebaseFirestore.instance
                                .collection('buy_flag')
                                .doc(AuthModel().user.email)
                                .collection('flag')
                                .doc(id.toString())
                                .update(data);
                            Navigator.pop(context);
                          }
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
        await FirebaseFirestore.instance
            .collection('kanchan')
            .doc(AuthModel().user.email)
            .set({'dress': selectImage});
      },
      child: Image.asset(
        dressupImage,
        fit: BoxFit.cover,
      ),
    );
  }
}

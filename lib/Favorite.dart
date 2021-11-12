import 'package:flutter/material.dart';
import './Color.dart';
import './main.dart';
import './home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices2.length,
        child: Scaffold(
          body: Center(
            child: ChoiceCard2(),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Choice2 {
  String label;
  Widget widget;

  Choice2(this.label, this.widget);
}

final List<Choice2> choices2 = [
  //Choice2('おつまみ', LikeSnacks()),
  Choice2('カクテル', LikeCocktail()),
  Choice2('お酒', LikeSake()),
];

class ChoiceCard2 extends StatefulWidget {
  @override
  _ChoiceCardState2 createState() => _ChoiceCardState2();
}

class _ChoiceCardState2 extends State<ChoiceCard2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
              child: Text(
            'お気に入り',
            style: TextStyle(color: HexColor('43AA8B')),
          )),
          bottom: PreferredSize(
            child: TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: HexColor('43AA8B'),
              indicatorColor: HexColor('43AA8B'),
              tabs: choices2.map((Choice2 choice) {
                return Tab(
                  text: choice.label,
                );
              }).toList(),
            ),
            preferredSize: Size.fromHeight(15.0),
          ),
          backgroundColor: HexColor('f5f5f5'),
        ),
        body: TabBarView(children: choices2.map((tab) => tab.widget).toList()),
      ),
    );
  }
}

class LikeSnacks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: Text('お気に入りのおつまみ一覧表示！！'),
        )
      ],
    );
  }
}

//お気に入りに追加したカクテル一覧表示
class LikeCocktail extends StatefulWidget {
  @override
  _LikeCocktailState createState() => new _LikeCocktailState();
}

class _LikeCocktailState extends State {
  var favoriteLists;
  Future getState() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('favorites')
        .doc(AuthModel().user.email)
        .collection('カクテル')
        .snapshots()) {
      favoriteLists = [];
      for (var like in snapshot.docs) {
        setState(() {
          favoriteLists.add(like.data());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
      itemCount: favoriteLists == null ? 0 : favoriteLists.length,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: ObjectKey(favoriteLists[index]),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            color: Colors.redAccent[700],
            child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                child: Icon(Icons.delete, color: Colors.white)),
          ),
          confirmDismiss: (DismissDirection direction) async {
            return await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("確認"),
                  content: Text("削除します。よろしいですか？"),
                  actions: [
                    FlatButton(
                        onPressed: () async {
                          Navigator.of(context).pop(true);
                          await FirebaseFirestore.instance
                              .collection('favorites')
                              .doc(AuthModel().user.email)
                              .collection('カクテル')
                              .doc(favoriteLists[index]["id"].toString())
                              .delete();
                        },
                        child: const Text("削除")),
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("キャンセル"),
                    ),
                  ],
                );
              },
            );
          },
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeDetail(
                          favoriteLists[index]['id'],
                          favoriteLists[index]['name'],
                          favoriteLists[index]['ename'],
                          favoriteLists[index]['base'],
                          favoriteLists[index]['technique'],
                          favoriteLists[index]['taste'],
                          favoriteLists[index]['style'],
                          favoriteLists[index]['alcohol'],
                          favoriteLists[index]['topname'],
                          favoriteLists[index]['glass'],
                          favoriteLists[index]['digest'],
                          favoriteLists[index]['desc'],
                          favoriteLists[index]['recipe'],
                          favoriteLists[index]['recipes'],
                          favoriteLists[index]['state'],
                          AuthModel().user.email)));
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    width: 150,
                    height: 150,
                    imageUrl:
                        'https://dm58o2i5oqos8.cloudfront.net/photos/${favoriteLists[index]["id"]}.jpg',
                    errorWidget: (conte, url, dynamic error) =>
                        Image.asset('assets/InPreparation_sp.png'),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            favoriteLists[index]['digest'],
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Center(
                          child: Text(
                            favoriteLists[index]['name'],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LikeSake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: Text('お気に入りのお酒一覧表示！！'),
        )
      ],
    );
  }
}

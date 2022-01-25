import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrecipeDetail extends StatefulWidget {
  @override
  final int _index;
  final String _doc;
  OrecipeDetail(this._index, this._doc);
  _OrecipeDetailState createState() => new _OrecipeDetailState(_index, _doc);
}

//おつまみ作り方表示ページ
class _OrecipeDetailState extends State {
  final int _index;
  final String _doc;
  _OrecipeDetailState(this._index, this._doc);

  List snackData;
  List materials;
  List procedures;
  Future getSnackData() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('snacks').snapshots()) {
      snackData = [];
      for (var snack in snapshot.docs) {
        setState(() {
          snackData.add(snack.data());
        });
      }
    }
  }

  Future getMaterial() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('snacks')
        .doc(_doc)
        .collection('material')
        .orderBy('id')
        .snapshots()) {
      materials = [];
      for (var material in snapshot.docs) {
        setState(() {
          materials.add(material.data());
        });
      }
    }
  }

  Future getProcedure() async {
    await for (var snapshot in FirebaseFirestore.instance
        .collection('snacks')
        .doc(_doc)
        .collection('procedure')
        .snapshots()) {
      procedures = [];
      for (var procedure in snapshot.docs) {
        setState(() {
          procedures.add(procedure.data());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getSnackData();
    getMaterial();
    getProcedure();
  }

  @override
  Widget build(BuildContext context) {
    if (materials == null && procedures == null) {
      return Scaffold(
        body: Text(''),
      );
    } else {
      return ListView(children: [
        CachedNetworkImage(
          imageUrl: snackData[_index]['image'],
          errorWidget: (conte, url, dynamic error) =>
              Image.asset('assets/InPreparation_sp.png'),
        ),
        Text('${snackData[_index]['name']}\n',
            style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 5.0,
                color: Colors.black,
                decoration: TextDecoration.none)),
        Text('材料(${snackData[_index]['num']}人分)',
            style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 5.0,
                color: Colors.black,
                decoration: TextDecoration.none)),
        for (int i = 0; i < materials.length; i++)
          Container(
            decoration: BoxDecoration(
                border: const Border(
                    bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ))),
            child: ListTile(
                title: Flexible(
                    child: Row(
              children: [
                Container(
                  width: 200,
                  child: Text(
                    materials[i]["name"],
                  ),
                ),
                Text(materials[i]["amount"]),
              ],
            ))),
          ),
        Text('\n手順',
            style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 5.0,
                color: Colors.black,
                decoration: TextDecoration.none)),
        for (int i = 0; i < procedures.length; i++)
          Container(
            child: Text('${i + 1}. ${procedures[i]['detail']}\n',
                style: TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 5.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none)),
          ),
        Text('メモ\n',
            style: TextStyle(
                fontSize: 20.0,
                letterSpacing: 5.0,
                color: Colors.black,
                decoration: TextDecoration.none)),
        Text('${snackData[_index]['comment']}\n',
            style: TextStyle(
                fontSize: 16.0,
                letterSpacing: 5.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none)),
      ]);
    }
  }
}

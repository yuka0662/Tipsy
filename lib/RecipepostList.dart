//import 'dart:html';
import 'dart:async';

import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import './Color.dart';
import './Search.dart';
import './home.dart';
//import 'dart:math';

class RecipepostList extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State
{
  @override
  Widget build(BuildContext context)
  {
    //var list = ['Apple', 'Banana'];
    var list = ['紅茶のお酒', 'カシスウーロン'];
    return Scaffold
    (
      appBar: AppBar(
        title: Text('tipsy'),
        backgroundColor: HexColor('212738'),
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()))
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body:
        ListView.separated
        (
          itemBuilder: (BuildContext context, int index)
          {
            return _Recipelist(list[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return separatorItem();
          },
          itemCount: list.length,
        )
      // Center
      // (
      //   child:
        // SingleChildScrollView
        // (
        //   child: Row
        //   (
        //     children: [
        //       Container
        //       (
        //         child:
        //         //_Recipelist('紅茶のお酒-お湯割り-', Image.asset('fauchon_straight.jpg'))
        //         // _Recipelist('紅茶のお酒-お湯割り-'),
        //         Expanded
        //         (
        //           child:
        //             // ListView
        //             // (
        //             //   children: list
        //             // ),
        //             // Text('紅茶のお酒'),
        //             ListView(children: [list[]]),
        //         )
        //         // Expanded
        //         // (
        //         //   child:
        //           // ListView(
        //           //   children:
        //           //   [
        //           //     _Recipelist('紅茶のお酒-お湯割り-'),
        //           //     _Recipelist('カシスウーロン')
        //           //   ],
        //           // )
        //         // ListView
        //         // (
        //         //   children:<Widget>[
        //         //       ListTile(
        //         //         // leading: Image.network('https://www.asahibeer.co.jp/products/spirits_liqueur/liqueur/fauchon_koucha/'),
        //         //       title: Text("紅茶のお酒-お湯割り-"),),
        //         //       ListTile(
        //         //         // leading: Image.network('https://www.amazon.co.jp/%E3%83%8B%E3%83%83%E3%82%AB%E3%83%96%E3%83%A9%E3%83%B3%E3%83%87%E3%83%BC-%E3%83%8B%E3%83%83%E3%82%AB%E3%83%96%E3%83%A9%E3%83%B3%E3%83%87%E3%83%BCV-S-O-P%E7%99%BD-720ml/dp/B004Q2AE1S/ref=zg_bs_71631051_1?_encoding=UTF8&psc=1&refRID=3VPPQ9RC8NTKJN9RNMW6'),
        //         //       title: Text('ブランデー-ソーダ―割-'),
        //         //       ),
        //         //       ListTile(
        //         //         // leading: Image.network('https://www.amazon.co.jp/%E3%83%8B%E3%83%83%E3%82%AB%E3%83%96%E3%83%A9%E3%83%B3%E3%83%87%E3%83%BC-%E3%83%8B%E3%83%83%E3%82%AB%E3%83%96%E3%83%A9%E3%83%B3%E3%83%87%E3%83%BCV-S-O-P%E7%99%BD-720ml/dp/B004Q2AE1S/ref=zg_bs_71631051_1?_encoding=UTF8&psc=1&refRID=3VPPQ9RC8NTKJN9RNMW6'),
        //         //       title: Text('ブランデー-ソーダ―割-'),
        //         //       ),
        //         //       ListTile(
        //         //         // leading: Image.network('https://www.amazon.co.jp/%E3%83%8B%E3%83%83%E3%82%AB%E3%83%96%E3%83%A9%E3%83%B3%E3%83%87%E3%83%BC-%E3%83%8B%E3%83%83%E3%82%AB%E3%83%96%E3%83%A9%E3%83%B3%E3%83%87%E3%83%BCV-S-O-P%E7%99%BD-720ml/dp/B004Q2AE1S/ref=zg_bs_71631051_1?_encoding=UTF8&psc=1&refRID=3VPPQ9RC8NTKJN9RNMW6'),
        //         //       title: Text('ブランデー-ソーダ―割-'),
        //         //       ),
        //         //       ListTile(
        //         //         // leading: Image.network('https://www.amazon.co.jp/%E3%83%8B%E3%83%83%E3%82%AB%E3%83%96%E3%83%A9%E3%83%B3%E3%83%87%E3%83%BC-%E3%83%8B%E3%83%83%E3%82%AB%E3%83%96%E3%83%A9%E3%83%B3%E3%83%87%E3%83%BCV-S-O-P%E7%99%BD-720ml/dp/B004Q2AE1S/ref=zg_bs_71631051_1?_encoding=UTF8&psc=1&refRID=3VPPQ9RC8NTKJN9RNMW6'),
        //         //       title: Text('ブランデー-ソーダ―割-'),
        //         //       ),
        //         //   ]
        //         // ),
        //         )
        //       //)
        //     ],
        //   ),
        // )
      //)
    );
  }

   Widget separatorItem() {
    return Container(
      height: 10,
      // color: Colors.orange,
    );
  }
  // Widget _Recipelist(String title, Image image)
  Widget _Recipelist(String title)
  {
    return GestureDetector(
      child:Container(
        padding: EdgeInsets.all(8.0),
        decoration: new BoxDecoration(
          border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))
        ),
        child: Row(
          children: <Widget>[
            // Container(
            //   margin: EdgeInsets.all(50.0),
            //   child:image,
            // ),
            Text(
              title,
              style: TextStyle(
                color:Colors.black,
                fontSize: 18.0
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget _ImageList(Image image)
  {
    var imageList = {};
    return Scaffold
    (

    );
  }
}

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sample/ListItem.dart';
import 'package:sample/Top.dart';
import 'package:sample/main.dart';
// import './Header.dart';
import './Color.dart';
import './Search.dart';
import './ListItem.dart';


class Newpost extends StatefulWidget {
  @override
  // State<StatefulWidget> createState() {
  //     // TODO: implement createState
  //     return _State();
  //   }
  _State createState() => new _State();
}
class _State extends State
{
  List<String> processList = [];
  // List<String> items = [];
  var items = <String>[]; //材料追加
  var process = <String>[];  //手順
  //checkboxおつまみカテゴリーの初期設定
  var _meat = false;
  var _fish = false;
  var _sweet = false;
  var _salty = false;
  var _easy = false;
  var _tShort = false;
  var _snack = false;
  var _novelty = false;
  var _party = false;
  //Controller
  var _materialController = TextEditingController(); //材料
  var _text = ' '; //材料入力した値を入れる
  var _processController = TextEditingController(); //手順
  var _process = '　';  //手順入力した値を入れる
  var count = 0;

  void initState(){
    super.initState();
    _materialController = TextEditingController();
    _processController = TextEditingController();
  }

  void dispose(){
    super.dispose();
    _materialController.dispose();
    _processController.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
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
      Center
      (
        child:
        SingleChildScrollView
        (child:
          Container
        (
          width: 1000,
          child:
          Column
          (
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>
            [
              Container
              (
                padding: EdgeInsets.only(top:10),
                child: Text('新規投稿', style: TextStyle(fontSize: 20)),
              ),
              Container
              (
                padding: EdgeInsets.only(top:25),
                height: 100,
                child:
                Expanded
                (
                  flex: 3,
                  child:
                  //レシピ名入力欄
                  TextFormField
                  (
                    decoration: InputDecoration
                    (
                      enabledBorder: OutlineInputBorder
                      (
                        //borderSide: BorderSide(color: HexColor('212738')),
                      ),
                      labelText: 'レシピ名',
                      hintText: 'レシピ名を入力してください'
                    ),
                    autovalidate: false,  //入力変化しても自動でチェックしない
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return 'レシピ名を入力してください';
                      }
                      return null;  //問題ない場合、nullを返す
                    },
                  ),//レシピ名入力欄end
                ),
              ),
              Row
              (children:
                [
                  //肉のチェックボックス
                  Expanded
                  (child:
                    Container(
                      child:
                      CheckboxListTile
                      (
                        title: Text("肉"),
                        value: _meat,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool value){
                          setState(bool value){
                            _meat = value;
                          }
                        },
                      ),
                    ),
                  ),
                  //魚のチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("魚"),
                      value: _fish,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value){
                          setState(){
                            _fish = value;
                          }
                      },
                    )
                  ),
                  //甘いのチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("甘い"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value:  _sweet,
                      onChanged: (bool value){
                        setState(){
                         _sweet = value;
                        }
                      },
                    )
                  ),
                  //しょっぱいのチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("しょっぱい"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value:  _salty,
                      onChanged: (bool value){
                        setState(){
                         _salty = value;
                        }
                      },
                    )
                  ),
                ],
              ),
              Row
              (children:
                [
                  //簡単のチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("簡単"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value:  _easy,
                      onChanged: (bool value){
                        setState(){
                         _easy = value;
                        }
                      },
                    )
                  ),
                  //時短のチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("時短"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value:  _tShort,
                      onChanged: (bool value){
                        setState(){
                         _tShort = value;
                        }
                      },
                    )
                  ),
                  //スナックのチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("スナック"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value:  _snack,
                      onChanged: (bool value){
                        setState(){
                         _snack = value;
                        }
                      },
                    )
                  ),
                  //変わり種のチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("変わり種"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value:  _novelty,
                      onChanged: (bool value){
                        setState(){
                         _novelty = value;
                        }
                      },
                    )
                  ),
                  //パーティのチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("パーティ"),
                      controlAffinity: ListTileControlAffinity.leading,
                      value:  _party,
                      onChanged: (bool value){
                        setState(){
                         _party = value;
                        }
                      },
                    )
                  ),
                ],
              ),
              Row
              (children:
                [
                  Container
                  (
                    width: 500,
                    child:
                    Expanded
                    (
                      child:
                      //材料
                      TextFormField
                      (
                        controller: _materialController,
                        decoration: InputDecoration
                        (
                          enabledBorder: OutlineInputBorder
                          (
                            borderSide: BorderSide(color: HexColor('212738')),
                          ),
                          labelText: "材料",
                          hintText: "材料・用量を入力してください"
                        ),
                        // autovalidate: false,  //入力変化しても自動でチェックしない
                        // validator: (value)
                        // {
                        //   if(value.isEmpty)
                        //   {
                        //     return "材料・用量を入力してください";
                        //   }
                        //   return null;  //問題ない場合、nullを返す
                        // },
                      ),//材料end
                    ),
                  ),
                  //材料の追加
                  Expanded
                  (child:
                      RaisedButton
                      (
                        child: const Icon(Icons.add),
                        color: HexColor('212738'),
                        textColor: HexColor('FFFFFF'),
                        shape:  const CircleBorder(
                          side: BorderSide(
                            width: 1,
                          )
                        ),
                        onPressed: ()=> setState(
                          (){
                            _text = _materialController.text;
                            items.add(_text);
                        },
                        )
                      ),
                  ),
                ],
              ),
              Container
              (
                padding: EdgeInsets.only(top:10, bottom: 10),
                child: Expanded(child: Text(items.toString(), style: TextStyle(fontSize: 23, color: Colors.grey,),),),
              ),
              Row
              (children:
                [
                  Container
                  (
                    width: 500,
                    child:
                    Expanded
                    (
                      child:
                      //材料
                      TextFormField
                      (
                        controller: _processController,
                        decoration:
                        InputDecoration
                        (
                          enabledBorder: OutlineInputBorder
                          (
                            borderSide: BorderSide(color: HexColor('212738')),
                          ),
                          labelText: "手順",
                          hintText: "手順を入力してください"
                        ),
                      ),
                    ),//材料end
                  ),
                  //手順の追加
                  Expanded
                  (child:
                      RaisedButton
                      (
                        child: const Icon(Icons.add),
                        color: HexColor('212738'),
                        textColor: HexColor('FFFFFF'),
                        shape:  const CircleBorder(
                          side: BorderSide(
                            width: 1,
                          )
                        ),
                        onPressed: ()=> setState(
                          (){
                            // var i=0;
                            // process[i];
                            // _process = count.toString()+ "：" + _processController.text+"\n";
                            _process = _processController.text;
                            process.add(_process);

                        },
                        )
                      ),
                  ),
                  // Expanded(child: Text(_text),)
                  // Expanded(child: Text(itemsAdd[0])),
                ],
              ),
              Container
              (
                padding: EdgeInsets.only(top:10, bottom: 10),
                // child: Expanded(child: Text(process.toString(), style: TextStyle(fontSize: 23,),),),
                child:
                ListView.builder
                (
                  shrinkWrap: true,
                  itemCount: process.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container
                    (
                      padding: EdgeInsets.only(top:0.0, right: 0.0, bottom: 0.0, left: 0.0),
                      child: ListTile(title: Text("$index : ${process.toString()}", style: TextStyle(color: Colors.black, fontSize: 23,),),),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
        ),
      )
    );
  }
}

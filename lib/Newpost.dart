import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sample/main.dart';
import './Search.dart';
import './Color.dart';

class Newpost extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
      // TODO: implement createState
      return _State();
    }
}
class _State extends State
{
  var _meat = false;  //肉のチェックボックス
  var _fish = false;  //魚のチェックボックス
  var _sweet = false;  //甘いのチェックボックス
  var _salty = false; //しょっぱいのチェックボックス
  var _snack = false; //スナックのチェックボックス
  var _party = false; //パーティのチェックボックス
  var _novelty = false; //変わり種・珍味のチェックボックス
  var _easy = false; //簡単のチェックボックス
  var _timeShort = false; //時短のチェックボックス

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      //appBar: Bar_nav(),
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
      // body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      //   FloatingActionButton(
      //     onPressed: image_picker.Getim_camera(),
      //   )
      // ],),
      body:

      Center
      (
        child:
        Container
        (
          width: 1000,
          child:
          Column
          (
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>
            [
              Expanded(child: Spacer()),
              Expanded(
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
                      labelText: "レシピ名",
                      hintText: "レシピ名を入力してください"
                    ),
                    autovalidate: false,  //入力変化しても自動でチェックしない
                    validator: (value)
                    {
                      if(value.isEmpty)
                      {
                        return "レシピ名を入力してください";
                      }
                      return null;  //問題ない場合、nullを返す
                    },
                  ),//レシピ名入力欄end
                      //材料
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
                          setState((){
                            _meat = value;
                          });
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
                          setState((){
                            _fish = value;
                          });
                      },
                    )
                  ),
                  //甘いのチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("甘い"),
                      value:  _sweet,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value)
                      {
                         setState(() {
                          _sweet = value;
                         });
                      },
                    )
                  ),
                  //しょっぱいのチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("しょっぱい"),
                      value:  _salty,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value){
                        setState((){
                         _salty = value;
                        });
                      },
                    )
                  ),
                ],
              ),
              Row
              (children:
                [
                  //スナックのチェックボックス
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("スナック"),
                      value: _snack,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool value){
                        setState((){
                         _snack = value;
                        });
                      },
                    )
                  ),
                  //パーティ
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("パーティ"),
                      value: _party,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged:  (bool value){
                        setState((){
                         _party = value;
                        });
                      },
                    )
                  ),
                  //変わり種・珍味
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("変わり種"),
                      value: _novelty,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged:  (bool value){
                        setState((){
                         _novelty = value;
                        });
                      },
                    )
                  ),
                  //簡単
                  Expanded
                  (child:
                    CheckboxListTile
                    (
                      title: Text("簡単"),
                      value: _easy,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged:  (bool value){
                        setState((){
                         _easy = value;
                        });
                      },
                    )
                  ),
                  //時短
                  Expanded
                  (child:CheckboxListTile
                    (
                      title: Text("時短"),
                      value: _timeShort,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged:  (bool value){
                        setState((){
                         _timeShort = value;
                        });
                      },
                    )
                  ),
                ],
              ),
              // Expanded(child: Spacer()),
              //材料
              Row
              (children:
                [
                  Expanded
                  (
                    child:TextField
                    (
                      decoration: const InputDecoration
                      (
                        enabledBorder:
                        OutlineInputBorder(),
                        labelText: "材料",
                        hintText: "材料名・数量を入力してください"
                      ),
                    ),
                  ),
                  Expanded
                  (child:
                    IconButton
                    (
                      icon: const Icon(Icons.add),
                      tooltip: "材料を追加する",
                      onPressed: (){
                        // setState(()
                        //   { }
                        // )
                      },
                    )
                  ),
                  Expanded
                  (child:
                    IconButton
                    (
                      icon: const Icon(Icons.remove),
                      tooltip: "材料を追加する",
                      onPressed: (){
                        // setState(()
                        //   { }
                        // )
                      },
                    )
                  ),
                ],
              )
            ],

          ),
        ),
      )
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './Color.dart';
import './Search.dart';

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
  // @override
  // void initState(){
  //   super.initState();
  // }
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
        Container
        (
          width: 1000,
          child:
          Column
          (
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>
            [
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
              Row(children:
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
                        decoration: InputDecoration
                        (
                          enabledBorder: OutlineInputBorder
                          (
                            borderSide: BorderSide(color: HexColor('212738')),
                          ),
                          labelText: "材料",
                          hintText: "材料・容量を入力してください"
                        ),
                        autovalidate: false,  //入力変化しても自動でチェックしない

                      ),//材料end
                    ),
                  ),
                  Container
                  (
                    width: 100,
                    height: 50,
                    child:
                    Expanded
                    (child:
                      RaisedButton
                      (
                        child: const Text("追加"),
                        color: HexColor('212738'),
                        textColor: HexColor('FFFFFF'),
                        onPressed: (){},
                      )
                    ),
                  ),
                  //材料の入力欄追加
                  Expanded
                  (child:
                    IconButton
                    (
                      icon: const Icon(Icons.add),
                      color: HexColor('ffffff'),
                    )
                  )
                ],
              )
            ],

          ),
        ),
      )
    );
  }
}

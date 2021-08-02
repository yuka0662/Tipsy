//import 'dart:html';
//import 'dart:math';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './Color.dart';
import './Search.dart';
import './home.dart';


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
  // File _image;
  // final picker = ImagePicker();
  //File _image;
  //final picker = ImagePicker();
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
  var _processController = TextEditingController(); //手順

  // Future getImageFromCamera() async{
  //   final pickedFile = await picker.getImage(source: ImageSource.camera);

  //   setState(() {
  //       // _image = File(pickedFile.path);
  //   });
  // }

  // Future getImageFromGallery() async{
  //   final pickedImage = await picker.getImage(source: ImageSource.gallery);

  //   setState((){
  //     // _image = File(pickedImage.path);
  //   });
  // }

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
    final Size size = MediaQuery.of(context).size;
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
          width: size.width,
          height: size.height,
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
                width: 600,
                height: 100,
                child:
                Expanded
                (
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
              Container
              (
                width: 600,
                child:
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
                          contentPadding: EdgeInsets.all(0),
                          title: Text("肉",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
                          value: _meat,
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (bool value){
                            setState(()
                            {
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
                        contentPadding: EdgeInsets.all(0),
                        title: Text("魚",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
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
                        contentPadding: EdgeInsets.all(0),
                        title: Text("甘い",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
                        controlAffinity: ListTileControlAffinity.leading,
                        value:  _sweet,
                        onChanged: (bool value){
                          setState((){
                          _sweet = value;
                          });
                        },
                      )
                    ),
                  ],
                ),
              ),
              Container
              (
                width: 600,
                child:
                Row(
                  children: [
                    //しょっぱいのチェックボックス
                    Expanded
                    (child:
                      CheckboxListTile
                      (
                        contentPadding: EdgeInsets.all(0),
                        title: Text("しょっぱい",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
                        controlAffinity: ListTileControlAffinity.leading,
                        value:  _salty,
                        onChanged: (bool value){
                          setState((){
                          _salty = value;
                          });
                        },
                      )
                    ),
                     //簡単のチェックボックス
                    Expanded
                    (child:
                      CheckboxListTile
                      (
                        contentPadding: EdgeInsets.all(0),
                        title: Text("簡単",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
                        controlAffinity: ListTileControlAffinity.leading,
                        value:  _easy,
                        onChanged: (bool value){
                          setState((){
                          _easy = value;
                          });
                        },
                      )
                    ),
                    //時短のチェックボックス
                    Expanded
                    (child:
                      CheckboxListTile
                      (
                        contentPadding: EdgeInsets.all(0),
                        title: Text("時短",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
                        controlAffinity: ListTileControlAffinity.leading,
                        value:  _tShort,
                        onChanged: (bool value){
                          setState((){
                          _tShort = value;
                          });
                        },
                      )
                    ),
                  ],
                )
              ),
              Container(
                width: 600,
                child:
                Row
                (children:
                  [
                    //スナックのチェックボックス
                    Expanded
                    (child:
                      CheckboxListTile
                      (
                        contentPadding: EdgeInsets.all(0),
                        title: Text("スナック",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
                        controlAffinity: ListTileControlAffinity.leading,
                        value:  _snack,
                        onChanged: (bool value){
                          setState((){
                          _snack = value;
                          });
                        },
                      )
                    ),
                    //変わり種のチェックボックス
                    Expanded
                    (child:
                      CheckboxListTile
                      (
                        contentPadding: EdgeInsets.all(0),
                        title: Text("変わり種",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
                        controlAffinity: ListTileControlAffinity.leading,
                        value:  _novelty,
                        onChanged: (bool value){
                          setState((){
                          _novelty = value;
                          });
                        },
                      )
                    ),
                    //パーティのチェックボックス
                    Expanded
                    (child:
                      CheckboxListTile
                      (
                        contentPadding: EdgeInsets.all(0),
                        title: Text("パーティ",style: TextStyle(fontSize: 15, color:HexColor('707070'))),
                        controlAffinity: ListTileControlAffinity.leading,
                        value:  _party,
                        onChanged: (bool value){
                          setState((){
                          _party = value;
                          });
                        },
                      )
                    ),
                  ],
                ),
              ),
              Container
              (
                width: 600,
                child:
                Row
                (children:
                  [
                    Container
                    (
                      width: 300,
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
                              items.add(_materialController.text);
                          },
                          )
                        ),
                    ),
                  ],
                ),
              ),
              Container
              (
                padding: EdgeInsets.only(top:10, bottom: 10),
                child: ListView.builder
                (
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container
                    (
                      padding: EdgeInsets.only(top:0.0, right: 0.0, bottom: 0.0, left: 0.0),
                      child: ListTile(title: Text("${items[index]}", style: TextStyle(color: Colors.black, fontSize: 15,),),),
                    );
                  }
                  ),
              ),
              Container
              (
                width: 600,
                child:
                  Row
                  (children:
                    [
                      Container
                      (
                        width: 300,
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
                                process.add(_processController.text);
                              },
                            )
                          ),
                      ),
                  ],
                ),
              ),
              Container
              (
                padding: EdgeInsets.only(top:10, bottom: 10),
                child:
                ListView.builder
                (
                  shrinkWrap: true,
                  itemCount: process.length,
                  itemBuilder: (BuildContext context, int index){
                    return Container
                    (
                      padding: EdgeInsets.only(top:0.0, right: 0.0, bottom: 0.0, left: 0.0),
                      child: ListTile(title: Text("${index+1} : ${process[index]}", style: TextStyle(color: Colors.black, fontSize: 23,),),),
                    );
                  }
                ),
              ),
              Container
              (
                width: 600,
                child:
                Row
                (
                  children: [
                    Container
                    (
                      width: 150,
                      height: 50,
                      child:
                      SizedBox(
                        child:
                        RaisedButton
                        (
                          child: Text('キャンセル'),
                          onPressed:()=>{
                            Navigator.pop(context)
                          }
                        ),
                      )
                    ),
                    Container(padding: EdgeInsets.only(top:0.0, right: 0.0, bottom: 0.0, left: 110.0),),
                    Container
                    (
                      width: 150,
                      height: 50,
                      child:
                      RaisedButton
                      (
                        child: Text('投稿する'),
                        color: HexColor('212738'),
                        textColor: HexColor('FFFFFF'),
                        // splashColor: HexColor('08FFC8'),
                        onPressed: ()=>{
                            Navigator.push
                            (
                              context,
                              MaterialPageRoute
                              (
                                builder: (context)=>Home(),
                                fullscreenDialog: true,
                              )
                            )
                        },
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
        ),
      )
    );
  }
}

import 'dart:html';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sample/main.dart';
import './Header.dart';
import './Image_picker.dart';


class Newpost extends StatelessWidget
{

  Image_picker image_picker = Image_picker();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: Bar_nav(),
      // body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      //   FloatingActionButton(
      //     onPressed: image_picker.Getim_camera(),
      //   )
      // ],),
      body:Column
      (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>
        [
          Text("aaa"),
              Expanded(
                child:
                  //レシピ名入力欄
                  
                  TextFormField
                  (
                    decoration: const InputDecoration
                    (
                      enabledBorder: OutlineInputBorder
                      (
                        borderSide: BorderSide(color: Colors.blueGrey,)
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
                  
              )
            ],
      )
    );
  }

}

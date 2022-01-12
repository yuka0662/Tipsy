import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './Color.dart';


class Knowledge extends StatelessWidget{
  @override
  final List<String> list=<String>[
    "酔っていても家にたどり着けるのはどうして？",
    "ワインの熟成年数を早める魔法の杖があるの？",
    "ビールを注ぎ足す行為は好まれない？",
    "イギリスにはサソリが入ったお酒がある？",
    "カクテル言葉ってあるの？",
    "ビールはキンキンじゃない方が美味しいこともある",
    "アルコール度数96度のお酒があるのって本当？",
    "ビールががぶ飲みできるわけは？",
    "旅行先で確実にビールを飲むために",
    "瓶ビールの栓の王冠のギザギザの数は21個って本当？",
  ];
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('雑学'),
        backgroundColor: HexColor('212738'),
        actions: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right:20),
            child: Text('3回', style: TextStyle(fontSize: 20),),
          )
        ],
      ),
      body:Container
        (
          child:ListView.builder(
            padding: const EdgeInsets.all(8),itemCount: list.length,
            itemBuilder:(BuildContext context, int index){
              return Container(
                decoration: new BoxDecoration(
                  border: new Border(
                    bottom: new BorderSide(color: Colors.grey),
                  )
                ),
                height: 60,
                child:
                    ListTile(
                      title: Container(child: Text('${list[index]}', style: TextStyle(fontSize: 18),overflow: TextOverflow.ellipsis,),),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary:Colors.transparent, elevation:0, onPrimary: Colors.black),
                        child: Text('開放', style: TextStyle(color: HexColor('3185FC')),),
                        onPressed: (){},
                      ),
                    )
              );
            }
          ),
        ),
    );
  }
}

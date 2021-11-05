import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './Color.dart';
import './Search.dart';
import './home.dart';

class Knowledge extends StatefulWidget {
  @override

  _State createState() => new _State();
}

class _State extends State {
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Scaffold
    (
      appBar: AppBar(
        title: Text('tipsy'),
        backgroundColor: HexColor('212738'),
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()))
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body:
      Center(
        child:
        ListView(
          children:[
            SingleChildScrollView
            (
              child:
              Row(
                children:[
                  Container(child: Text("雑学開放"),),
                  Row(children: [Container(child:Text("給水回数："), ),],)
              ],
              // Row(children: [],)
              )
            )
          ],
        )
      )
    );
  }
}

import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget{
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox>{
  bool flag  = false;
  void handleCheckbox(bool check){
    setState(() {
      flag = check;
    });
  }

  Widget build(BuildContext context){
    return Container(child:
      CheckboxListTile
      (
        onChanged: handleCheckbox,
      )
    ,);
  }
}

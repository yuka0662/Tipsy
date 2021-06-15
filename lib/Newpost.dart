import 'dart:html';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/main.dart';
import './Header.dart';
import './Image_picker.dart';


class Newpost extends StatelessWidget {

  Image_picker image_picker = Image_picker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar_nav(),
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        FloatingActionButton(
          onPressed: image_picker.Getim_camera(),
        )
      ],),
    );

  }

}

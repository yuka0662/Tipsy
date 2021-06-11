import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class _HomePageState extends State<HomePage>{
  File _image;
  final picker = ImagePicker();

  //カメラから画像を取得
  //カメラから画像を取得する関数
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState((){
      _image = File(pickedFile.path);
    });
  }

  //ギャラリーから画像を取得
  //ギャラリーから画像を取得する関数
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source:ImageSource.gallery);

    setState((){
      _image = File(pickedFile.path);
    });
  }

}

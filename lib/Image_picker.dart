import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/main.dart';

//runAppメソッドは引数のWidgetをスクリーンにアタック
//runAppメソッドの引数のWidgetが画面いっぱいに表示する
void main() => runApp(new MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       home: Image(),
//     );
//   }
// }
class Image extends StatefulWidget{
  @override
  Image_picker createState() => Image_picker();
}
class Image_picker extends State<Image>{
  @override
  Widget build(BuildContext context){
    File _image;
    final picker = ImagePicker();


    //カメラから画像を取得
    //カメラから画像を取得する関数
    Future Getim_camera() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      final File file = File(pickedFile.path);

      setState((){
          if(kIsWeb){
            //_image = Image.network(pickedFile.path);
          }
      });
    }

    //ギャラリーから画像を取得
    //ギャラリーから画像を取得する関数
    Future Getim_gallery() async {
      final pickedFile = await picker.getImage(source:ImageSource.gallery);

      setState((){
        _image = File(pickedFile.path);
      });
    }

  }
}

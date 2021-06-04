import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './Header.dart';


class Newpost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar_nav(),
    );

  }
}


// class ImagePicker{
  
//   File _image;
//   final picker = ImagePicker();


//   //ギャラリーから画像を取得
//   Future getImageFromGallery() async {

//     final pickedFile = await picker.getImage(source: ImageSource.gallery);

//     setState((){
//       _image = File(pickedFile.path);
//     });
//   }

//   body :Center(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//          children: [
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                  width: 300,
//                  child: _image == null
//                      ? Text('No image selected.')
//                      : Image.file(_image)
//     )
//   )

//}

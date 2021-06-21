import 'package:flutter/material.dart';

//カラーコードで色選択ができる設定
//カラーコードで色選択をする場合はこのファイルを読み込んで、HexColor('数字')で宣言してください
class HexColor extends Color {
 static int _getColorFromHex(String hexColor) {
   hexColor = hexColor.toUpperCase().replaceAll('#', '');
   if (hexColor.length == 6) {
     hexColor = 'FF' + hexColor;
   }
   return int.parse(hexColor, radix: 16);
 }

 HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
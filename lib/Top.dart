import 'package:flutter/material.dart';

class Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SlidePage();
     
  }
}
class SlidePage extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}
 
 
class _SlideshowState extends State<SlidePage> {
 
  // ページコントローラ
  final PageController controller = PageController(viewportFraction: 0.8);
 
  // ページインデックス
  int currentPage = 0;
 
  // データ
  List<String> imageList = [
    "images/aki.png", 
    "images/gift.png",     
    "images/otsumami.png"
  ];
 
 
  @override
  void initState() {
 
    super.initState();
 
    // ページコントローラのページ遷移を監視しページ数を丸める
    controller.addListener(() {
      int next = controller.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  } 
 
  /*
   * アニメーションカード生成
   */
  AnimatedContainer _createCardAnimate(String imagepath, bool active) {
 
    // アクティブと非アクティブのアニメーション設定値
    final double top = active ? 100 : 200;
    final double side = active ? 0 : 40;
 
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50.0, right: side, left: side),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: Image.asset(imagepath).image,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
 
    return PageView.builder(
      controller: controller,
      itemCount: imageList.length,
      itemBuilder: (context, int currentIndex) {
 
        // アクティブ値
        bool active = currentIndex == currentPage;
 
        // カードの生成して返す
        return _createCardAnimate(
          imageList[currentIndex],
          active,
        );
      },
    );
  }
}
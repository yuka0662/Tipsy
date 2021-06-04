import 'package:flutter/material.dart';

class Bar_nav extends StatelessWidget with PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tipsy'),
        backgroundColor: Colors.black,
        leading:Icon(Icons.menu),
        actions:<Widget> [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.search),
          )
        ],
      )
    );
  }
}

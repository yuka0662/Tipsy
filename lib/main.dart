import 'package:flutter/material.dart';
import './Color.dart';
import './home.dart';
import './Search.dart';
import './Liquor.dart';
import './Favorite.dart';
import './Timer.dart';
import './Newpost.dart';
import './Header.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/user': (BuildContext context) => UserPage(),
        '/password': (BuildContext context) => PasswordPage(),
        '/add': (BuildContext context) => AddPage(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final _pageWidgets = [
    Home(),
    Liquor(),
    Favorite(),
    Timer(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('tipsy'),
        backgroundColor: HexColor('212738'),
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()))
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Tipsy',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: HexColor('212738'),
              ),
            ),
            ListTile(
              title: Text('ユーザー情報の変更'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/user');
              },
            ),
            ListTile(
              title: Text('パスワードの変更'),
              leading: Icon(Icons.vpn_key),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/password');
              },
            ),
            ListTile(
              title: Text('レシピ投稿一覧'),
              leading: Icon(Icons.menu_book),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/add');
              },
            ),
            ListTile(
              title: Text('ログアウト'),
              leading: Icon(Icons.logout),
            ),
          ],
        ),
      ),
      //タブによって表示内容が変わる(body部分)
      body: _pageWidgets.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton(
        //新規投稿ボタンのタップ時のイベント,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Newpost(),
              )
            );
        },
        tooltip: 'Increment',
        backgroundColor: HexColor('43AA8B'),
        child: Icon(Icons.add),
      ),
      //下のナビゲーションバー
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('ホーム')),
          BottomNavigationBarItem(
              icon: Icon(Icons.liquor), title: Text('お酒診断')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('お気に入り')),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), title: Text('タイマー')),
        ],
        currentIndex: _currentIndex,
        fixedColor: HexColor('08FFC8'),
        unselectedItemColor: Colors.white,
        backgroundColor: HexColor('212738'),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

//Drawerの移動先
class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー情報の変更'),
        backgroundColor: HexColor('212738'),
      ),
      body: Center(
        child: Center(
          child: Text('ユーザーの情報を変更できるよ！'),
        ),
      ),
    );
  }
}

class PasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('パスワード変更'),
        backgroundColor: HexColor('212738'),
      ),
      body: Center(
        child: Center(
          child: Text('パスワード変更できるよ！'),
        ),
      ),
    );
  }
}

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('レシピ投稿一覧'),
        backgroundColor: HexColor('212738'),
      ),
      body: Center(
        child: Center(
          child: Text('投稿したレシピの一覧が見れるよ！'),
        ),
      ),
    );
  }
}

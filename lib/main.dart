import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './Color.dart';
import './home.dart';
import './Search.dart';
import './Liquor.dart';
import './Favorite.dart';
import './Timer.dart';
import './Newpost.dart';

import './signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("ja"),
      ],
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
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return MyAuthPage();
                  }),
                );
              },
            ),
          ],
        ),
      ),
      //タブによって表示内容が変わる(body部分)
      body: _pageWidgets.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton.extended(
        //新規投稿ボタンのタップ時のイベント,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Newpost(),
              ));
        },
        tooltip: 'Increment',
        backgroundColor: HexColor('43AA8B'),
        icon: Icon(Icons.add),
        label: const Text('レシピ追加'),
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

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserState();
  }
}

//Drawerの移動先
class _UserState extends State {
  String _type;
  void _handleRadio(String e) => setState(() {
        _type = e;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザー情報の変更'),
        backgroundColor: HexColor('212738'),
      ),
      body: Column(children: <Widget>[
        //ここにimagepickerの追加
        Container(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            initialValue: 'お酒大好き',
            decoration: InputDecoration(
              icon: Icon(Icons.face),
              labelText: 'ユーザー名',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            initialValue: 'osake.like@like.ac.jp',
            decoration: InputDecoration(
              icon: Icon(Icons.markunread),
              labelText: 'メールアドレス',
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            enabled: false,
            //databaseから値を取ってくる
            initialValue: '1999年05月13日',
            decoration: const InputDecoration(
              labelText: '生年月日',
            ),
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(children: <Widget>[
            Text('性別', style: TextStyle(fontSize: 15, color: Colors.grey)),
          ]),
        ),
        Row(children: <Widget>[
          new Radio(
            activeColor: Colors.blue,
            value: 'men',
            groupValue: _type,
            onChanged: _handleRadio,
          ),
          new Text('男性'),
          new Radio(
            activeColor: Colors.blue,
            value: 'women',
            groupValue: _type,
            onChanged: _handleRadio,
          ),
          new Text('女性'),
          new Radio(
            activeColor: Colors.blue,
            value: 'other',
            groupValue: _type,
            onChanged: _handleRadio,
          ),
          new Text('その他'),
        ]),
        Container(
          child: RaisedButton(
            onPressed: () => {
              Navigator.pop(context) // 呼び出し元に戻る
              //検索条件を保持してデータベースから探して呼び出し元の画面にて表示
            },
            child: Text('変更'),
          ),
        ),
      ]),
    );
  }
}

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State {
  //final AuthService _auth = AuthService();
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('パスワード変更'),
        backgroundColor: HexColor('212738'),
      ),
      body: Column(children: <Widget>[
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 100.0, 0, 5.0),
            child: Text('メールアドレス'),
          ),
        ]),
        Container(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'sample@co.jp',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Container(
          child: FlatButton(
              color: Colors.blue,
              onPressed: () async {
                /*
                String _result = await _auth.passwordResetEmail(_email);

                // 成功時は戻る
                if (_result == 'success') {
                  Navigator.pop(context);
                } else if (_result == 'ERROR_INVALID_EMAIL') {
                  Flushbar(
                    message: "無効なメールアドレスです",
                    backgroundColor: Colors.red,
                    margin: EdgeInsets.all(8),
                    borderRadius: 8,
                    duration: Duration(seconds: 3),
                  )..show(context);
                } else if (_result == 'ERROR_USER_NOT_FOUND') {
                  Flushbar(
                    message: "メールアドレスが登録されていません",
                    backgroundColor: Colors.red,
                    margin: EdgeInsets.all(8),
                    borderRadius: 8,
                    duration: Duration(seconds: 3),
                  )..show(context);
                } else {
                  Flushbar(
                    message: "メール送信に失敗しました",
                    backgroundColor: Colors.red,
                    margin: EdgeInsets.all(8),
                    borderRadius: 8,
                    duration: Duration(seconds: 3),
                  )..show(context);
                }
                */
              }),
        ),
      ]),
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

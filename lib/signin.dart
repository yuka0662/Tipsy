import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './main.dart';
import './Color.dart';
import 'package:intl/intl.dart';

class MyAuthPage extends StatefulWidget {
  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('212738'),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.fromLTRB(24, 100, 24, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child:
                    // メールアドレス入力
                    TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'メールアドレス'),
                  onChanged: (String value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child:
                    // パスワード入力
                    TextFormField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'パスワード'),
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                  'パスワードをお忘れの方はこちら',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PasswordPage()));
                },
              ),
              Container(
                padding: EdgeInsets.all(8),
                // メッセージ表示
                child: Text(
                  infoText,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                // ログイン登録ボタン
                child: RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'ログイン',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    try {
                      // メール/パスワードでログイン
                      final user = (await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: this.email, password: this.password))
                          .user;
                      // ログインに成功した場合
                      // ホーム画面へ遷移
                      await Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return MyHomePage();
                        }),
                      );
                    } catch (e) {
                      // ログインに失敗した場合
                      setState(() {
                        infoText = "ログインに失敗しました：${e.toString()}";
                      });
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(
                  '登録がまだの方はこちら',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SigninPage()));
                },
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  // メッセージ表示用
  String infoText = '';
  // 入力したメールアドレス・パスワード
  String email = '';
  String password = '';
  //誕生日表示用
  String bday = '';

  var _labelText = '誕生日を選択する';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
      context: context,
      locale: const Locale("ja"),
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (selected != null) {
      setState(() {
        _labelText = (DateFormat.yMMMd('ja')).format(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('212738'),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, 100, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child:
                      // メールアドレス入力
                      TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'メールアドレス'),
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child:
                      // パスワード入力
                      TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'パスワード'),
                    obscureText: true,
                    onChanged: (String value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
                Text(
                  _labelText,
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () => _selectDate(context),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  // メッセージ表示
                  child: Text(
                    infoText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  width: double.infinity,
                  // ユーザー登録ボタン
                  child: ElevatedButton(
                    child: Text('ユーザー登録'),
                    onPressed: () async {
                      try {
                        // メール/パスワードでユーザー登録
                        final user = (await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: this.email, password: this.password))
                            .user;

                        // ユーザー登録に成功した場合
                        // ログイン画面へ遷移
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return MyAuthPage();
                          }),
                        );
                      } catch (e) {
                        // ユーザー登録に失敗した場合
                        setState(() {
                          infoText = "登録に失敗しました：${e.toString()}";
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

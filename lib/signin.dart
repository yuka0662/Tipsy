import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './main.dart';
import './Color.dart';
import 'package:intl/intl.dart';
// import 'validatable.dart';

class MyAuthPage extends StatefulWidget {
  @override
  _MyAuthPageState createState() => _MyAuthPageState();
}

class _MyAuthPageState extends State<MyAuthPage> {
  // メッセージ表示用
  String infoText = '';
  String notmatch = '';
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
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                    if (email != '' && password != '') {
                      try {
                        // メール/パスワードでログイン
                        final user = (await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: this.email, password: this.password));

                        // ログインに成功した場合
                        // ホーム画面へ遷移
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) {
                            return MyHomePage(user.user.email);
                          }),
                        );
                      } catch (e) {
                        // ログインに失敗した場合
                        setState(() {
                          infoText = "ログインに失敗しました：${e.toString()}";
                        });
                      }
                    } else if (email == '' && password != '') {
                      setState(() {
                        infoText = "メールアドレスを入力してください";
                      });
                    } else if (email != '' && password == '') {
                      setState(() {
                        infoText = "パスワードを入力してください";
                      });
                    } else if (email == '' && password == '') {
                      setState(() {
                        infoText = "メールアドレスとパスワードを入力してください";
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
  String notMatch = '';
  // 入力したメールアドレス・パスワード・アカウント名
  String email = '';
  String password = '';
  String password_confirm = '';
  var _password = TextEditingController();
  var _password_confirm = TextEditingController();
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

  Future setBuyFlag(int id) async {
    var data = {
      'id': id,
      'flag': false,
    };
    await FirebaseFirestore.instance
        .collection('buy_flag')
        .doc(email)
        .collection('flag')
        .doc(id.toString())
        .set(data);
  }

  String _type;
  void _handleRadio(String e) => setState(() {
        _type = e;
      });

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
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child:
                      // メールアドレス入力
                      TextFormField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'メールアドレス(必須)'),
                    onChanged: (String value) {
                      setState(() {
                        email = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child:
                      // パスワード入力
                      TextFormField(
                    controller: _password,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'パスワード(必須)'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "パスワードを入力してください";
                      }
                      if (value.length <= 8) {
                        return "8文字以上入力してください";
                      }
                      return null;
                    },
                    onChanged: (String value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: Column(
                    children: <Widget>[
                      // Text(
                      //   '※コメントを投稿する際に使用する名前です',
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      // パスワード確認の入力
                      TextFormField(
                        controller: _password_confirm,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        // controller: password_confirm,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'パスワード確認'),
                        obscureText: true,
                        validator: (value) {
                          if (value != password) {
                            String Error_pass = "パスワードが一致しません";
                            return Error_pass;
                            // return Error;
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            password_confirm = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    notMatch,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(children: <Widget>[
                    Text('　生年月日(必須)',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          _labelText,
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                    )
                  ]),
                ),
                Container(padding: EdgeInsets.all(20)),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(children: <Widget>[
                    Text('　性別(必須)　',
                        style: TextStyle(fontSize: 16, color: Colors.black)),
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
                      if (email != '' &&
                          password != '' &&
                          password_confirm != '' &&
                          _labelText != '' &&
                          _type != '' &&
                          password == password_confirm) {
                        try {
                          // メール/パスワードでユーザー登録
                          final user = (await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: this.email,
                                      password: this.password))
                              .user;
                          var data = {
                            'nickname': '',
                            'birthday': _labelText,
                            'gender': _type
                          };
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(email)
                              .set(data);

                          for (int i = 0; i < 12; i++) {
                            setBuyFlag(i);
                          }
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
                      } else {
                        setState(() {
                          infoText = "必須項目を入力してください";
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

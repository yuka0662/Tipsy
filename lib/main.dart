import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './Color.dart';
import './home.dart';
//import './Search.dart';
import './Liquor.dart';
import './Favorite.dart';
import './DressUp.dart';
import './Timer.dart';
import './Newpost.dart';
import './RecipepostList.dart';
import './signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        '/recipepostlist': (BuildContext context) => RecipepostList(),
        '/password': (BuildContext context) => PasswordPage(),
      },
      home: _LoginCheck(),
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

class _LoginCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool _loggedIn = AuthModel().loggedIn;
    return _loggedIn ? MyHomePage(AuthModel().user.email) : MyAuthPage();
  }
}

class AuthModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  User get user => _user;

  bool get loggedIn => _user != null;

  AuthModel() {
    final User _currentUser = _auth.currentUser;
    if (_currentUser != null) {
      _user = _currentUser;
      notifyListeners();
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.email);
  final String email;

  @override
  _MyHomePageState createState() => _MyHomePageState(email);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(this.email);
  final String email;

  int _currentIndex = 0;
  final _pageWidgets = [
    Home(),
    LiquorStart(),
    Favorite(),
    DressUp(),
    TimerStartPage(),
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
        /*
        actions: <Widget>[
          IconButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchPage()))
            },
            icon: Icon(Icons.search),
          )
        ],
        */
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
              title: Text('????????????????????????????????????'), //?????????
              leading: Icon(Icons.account_circle),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserPage(email)));
              },
            ),
            ListTile(
              title: Text('????????????????????????'),
              leading: Icon(Icons.vpn_key),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/password');
              },
            ),
            /*
            ListTile(
              title: Text('?????????????????????'),
              leading: Icon(Icons.menu_book),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/recipepostlist');
              },
            ),
            */
            ListTile(
              title: Text('???????????????'),
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
      //??????????????????????????????????????????(body??????)
      body: _pageWidgets.elementAt(_currentIndex),
      /*
      floatingActionButton: FloatingActionButton.extended(
        //???????????????????????????????????????????????????,
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
        label: const Text('???????????????'),
      ),
      */
      //?????????????????????????????????
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('?????????')),
          BottomNavigationBarItem(
              icon: Icon(Icons.liquor), title: Text('????????????')),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), title: Text('???????????????')),
          BottomNavigationBarItem(
              icon: Text(
                '???',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              title: Text('????????????')),
          BottomNavigationBarItem(
              icon: Icon(Icons.access_time), title: Text('????????????')),
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
  UserPage(this._email);
  final String _email;
  _UserPageState createState() => new _UserPageState(_email);
}

//?????????????????????????????????????????????(????????????????????????????????????)
class _UserPageState extends State {
  _UserPageState(this._email);
  final String _email;

  String _type, nickname, birthday, nname;

  void _handle(String e) {
    setState(() {
      _type = e;
    });
  }

  void _changeuser(String e) {
    setState(() {
      nickname = e;
    });
  }

  Future getUser() async {
    var docRef = FirebaseFirestore.instance.collection('users').doc(_email);
    docRef.get().then((doc) {
      //if (doc.exists) {
      setState(() {
        nickname = doc.get('nickname');
        birthday = doc.get('birthday');
        _type = doc.get('gender');
      });
      //}
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    if (nickname != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('????????????????????????????????????'),
            backgroundColor: HexColor('212738'),
          ),
          body: ListView(children: <Widget>[
            //?????????imagepicker?????????
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: nickname,
                decoration: InputDecoration(
                  icon: Icon(Icons.face),
                  labelText: '???????????????',
                ),
                onChanged: _changeuser,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                enabled: false,
                initialValue: _email,
                decoration: InputDecoration(
                  icon: Icon(Icons.markunread),
                  labelText: '?????????????????????',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                enabled: false,
                //database???????????????????????????
                initialValue: birthday,
                decoration: const InputDecoration(
                  labelText: '????????????',
                ),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: <Widget>[
                Text('??????', style: TextStyle(fontSize: 15, color: Colors.grey)),
              ]),
            ),
            Row(children: <Widget>[
              new Radio(
                activeColor: Colors.blue,
                value: 'men',
                groupValue: _type,
                onChanged: _handle,
              ),
              new Text('??????'),
              new Radio(
                activeColor: Colors.blue,
                value: 'women',
                groupValue: _type,
                onChanged: _handle,
              ),
              new Text('??????'),
              new Radio(
                activeColor: Colors.blue,
                value: 'other',
                groupValue: _type,
                onChanged: _handle,
              ),
              new Text('?????????'),
            ]),
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
              child: RaisedButton(
                onPressed: () async {
                  try {
                    var data = {
                      'nickname': nickname,
                      'birthday': birthday,
                      'gender': _type
                    };
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(_email)
                        .update(data);
                    Navigator.pop(context); // ????????????????????????
                  } catch (e) {}
                },
                child: Text('??????'),
              ),
            ),
          ]));
    } else {
      return Scaffold(
        body: Text(''),
      );
    }
  }
}

class PasswordPage extends StatefulWidget {
  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email = '';
  String msg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('?????????????????????'),
        backgroundColor: HexColor('212738'),
      ),
      body: Column(children: <Widget>[
        Row(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(30.0, 100.0, 0, 5.0),
            child: Text('?????????????????????'),
          ),
        ]),
        Container(
          padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 30.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'sample@co.jp',
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() {
                email = value;
              });
            },
          ),
        ),
        Text(msg, style: TextStyle(color: Colors.red)),
        Container(
          child: FlatButton(
              color: HexColor('212738'),
              child: Text(
                '??????????????????',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (email == '') {
                  setState(() {
                    msg = '????????????????????????????????????????????????';
                  });
                } else {
                  try {
                    await _auth.sendPasswordResetEmail(email: this.email);

                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                        content: const Text('??????????????????????????????\n????????????????????????????????????'),
                        duration: const Duration(seconds: 5),
                        action: SnackBarAction(
                          label: 'OK',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )));
                  } catch (e) {
                    setState(() {
                      msg = e.toString();
                    });
                  }
                }
              }),
        ),
      ]),
    );
  }
}

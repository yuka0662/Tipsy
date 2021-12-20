import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Color.dart';
import 'main.dart';

var _dropdownValue;

class TimerStartPage extends StatefulWidget {
  @override
  TimerStartPage();
  TimerStartState createState() => TimerStartState();
}

class TimerStartState extends State {
  List<DropdownMenuItem<int>> _items = List();
  var val = 0;
  DateTime time;
  //給水回数
  int cnt;
  //合計取得
  int sum;
  Future getTimer() async {
    var docRef = FirebaseFirestore.instance
        .collection('timer')
        .doc(AuthModel().user.email);
    docRef.get().then((doc) {
      //if (doc.exists) {
      setState(() {
        sum = doc.get('point');
        cnt = doc.get('ws_cnt');
      });
      //}
    });
  }

  void pushWithReloadByReturn(BuildContext context) async {
    // [*2]
    final result = await Navigator.push(
      // [*3]
      context,
      new MaterialPageRoute<bool>(
        // [*4]
        builder: (BuildContext context) => TimerPage(time, sum, cnt),
      ),
    );

    if (result) {
      // [*5]
      setState(() {
        getTimer();
      });
      // notifyListeners();
    }
  }

  /// 初期化処理
  @override
  void initState() {
    super.initState();
    setItems();
    getTimer();
  }

  void setItems() {
    _items
      ..add(DropdownMenuItem(
        child: Text(
          '10秒',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 0,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '30分',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 1,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '1時間',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 2,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '1時間30分',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 3,
      ))
      ..add(DropdownMenuItem(
        child: Text(
          '2時間',
          style: TextStyle(fontSize: 20.0),
        ),
        value: 4,
      ));
  }

  @override
  Widget build(BuildContext context) {
    _dropdownValue = _items[0].value;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.all(20)),
            /*Container(
              height: 100,
              child: Image.asset(''),
            ),*/
            //Text('${sum.toString()}pt,${cnt.toString()}回'),
            Text('※給水時間を設定してください'),
            DropdownButton(
              itemHeight: 50,
              items: _items,
              value: _dropdownValue,
              onChanged: (value) {
                setState(() {
                  _dropdownValue = value;
                });
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 90,
                        child: RaisedButton(
                            color: HexColor('212738'),
                            child: Text('開始',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onPressed: () async {
                              switch (_dropdownValue) {
                                case 0:
                                  time = DateTime.utc(0, 0, 0)
                                      .add(Duration(seconds: 10));
                                  break;
                                case 1:
                                  time = DateTime.utc(0, 0, 0)
                                      .add(Duration(minutes: 30));
                                  break;
                                case 2:
                                  time = DateTime.utc(0, 0, 0)
                                      .add(Duration(hours: 1));
                                  break;
                                case 3:
                                  time = DateTime.utc(0, 0, 0)
                                      .add(Duration(hours: 1, minutes: 30));
                                  break;
                                case 4:
                                  time = DateTime.utc(0, 0, 0)
                                      .add(Duration(hours: 2));
                                  break;
                                default:
                              }
                              pushWithReloadByReturn(context);
                            })),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// タイマーページ
class TimerPage extends StatefulWidget {
  final DateTime _time;
  final int _sum, _cnt;
  const TimerPage(this._time, this._sum, this._cnt);
  @override
  _TimerPageState createState() =>
      _TimerPageState(this._time, this._sum, this._cnt);
}

/// タイマーページの状態を管理するクラス
class _TimerPageState extends State<TimerPage> with WidgetsBindingObserver {
  //設定時刻
  DateTime _time;
  //合計給水回数,合計ポイント
  int _sum, _cnt;
  _TimerPageState(this._time, this._sum, this._cnt);
  //経過時間
  DateTime _timenow;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer _timer; // タイマーオブジェクト
  //bool _isTimerPaused = false; // バックグラウンドに遷移した際にタイマーがもともと起動中で、停止したかどうか
  //DateTime _pausedTime; // バックグラウンドに遷移した時間
  //int _notificationId; // 通知ID
  //開始時刻
  final DateTime now = DateTime.now();
  //終了時刻
  DateTime end;
  //終了してから三分を測る変数
  int endcnt = 180;
  //終了が押されるまでに給水された回数と取得ポイント
  int sum = 0;
  int cnt = 0;
  Timer _edittimer;

  /// 初期化処理
  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  // タイマーを開始する
  void _startTimer() {
    _timenow = _time;
    if (_timer != null && _timer.isActive) _timer.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (mounted) {
        setState(() {
          _timenow = _timenow.add(Duration(seconds: -1));
          _handleTimeIsOver();
        });
      }
    }); // 1秒ずつ時間を減らす
  }

  void _resetTimer() {
    cnt += 1;
    sum += 10;
    if (mounted) {
      setState(() {
        _timenow = _time;
        _startTimer();
      });
    }
  }

  void _resetTimer2() {
    if (mounted) {
      setState(() {
        _timenow = _time;
        _startTimer();
      });
    }
  }

  // 時間がゼロになったらタイマーを止める
  void _handleTimeIsOver() async {
    if (_timenow != null && _timenow == DateTime.utc(0, 0, 0)) {
      _timenow = _time;
      _timer.cancel();
      //FlutterRingtonePlayer.playAlarm();
      _edittimer = Timer(Duration(seconds: endcnt), () {
        endcnt = 180;
        _resetTimer2();
        Navigator.pop(context);
      });
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('給水時間です'),
              content: Text('時間になりました。お水を飲みましょう'),
              actions: [
                FlatButton(
                  child: Text('給水'),
                  onPressed: () {
                    cnt += 1;
                    sum += 5;
                    endcnt = 180;
                    //FlutterRingtonePlayer.stop();
                    _resetTimer2();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      if (_edittimer != null && _edittimer.isActive) {
        _edittimer.cancel();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text('' /*'給水目安となる時間を選択してください\n展示期間中は10秒カウントしか\nできないようになっています。'*/,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center),
        ),
        Text(
          DateFormat.Hms().format(_timenow),
          style: Theme.of(context).textTheme.headline2,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          height: 100,
          width: double.infinity,
          child: RaisedButton(
              color: HexColor('212738'),
              onPressed: _resetTimer,
              child: Text(
                "給水",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          height: 100,
          width: double.infinity,
          child: RaisedButton(
              color: HexColor('212738'),
              onPressed: () async {
                _timer.cancel();
                end = DateTime.now();
                await showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        contentPadding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  '完遂！！',
                                  style: TextStyle(fontSize: 22),
                                ),
                              ),
                              Tooltip(
                                  message: MaterialLocalizations.of(context)
                                      .closeButtonTooltip,
                                  child: GestureDetector(
                                      onTap: () async {
                                        try {
                                          var data = {
                                            'point': _sum + sum,
                                            'ws_cnt': _cnt + cnt,
                                          };
                                          await FirebaseFirestore.instance
                                              .collection('timer')
                                              .doc(AuthModel().user.email)
                                              .set(data);
                                        } catch (e) {
                                          print("${e.toString()}");
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.close, size: 30))),
                            ],
                          ),
                          Center(
                            child: Text(
                              '${end != null ? end.difference(now).inHours % 24 : 0}　:　${end != null ? end.difference(now).inMinutes.remainder(60) % 60 : 0}　:　${end != null ? end.difference(now).inSeconds.remainder(60) % 60 : 0}\nのんだよ\n給水： ${cnt.toString()} 回',
                              style: TextStyle(height: 2.5, fontSize: 20),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Center(
                            child: Text(
                              '取得　　${sum.toString()} pt　',
                              style: TextStyle(height: 2.5, fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 10)
                        ],
                      );
                    });
                Navigator.pop(context, true);
              },
              child: Text(
                "終了",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
        ),
      ],
    ));
  }
}

/**
  // ライフサイクルが変更された際に呼び出される関数をoverrideして、変更を検知
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // バックグラウンドに遷移した時
      setState(_handleOnPaused);
    } else if (state == AppLifecycleState.resumed) {
      // フォアグラウンドに復帰した時
      setState(_handleOnResumed);
    }
  }

  /// アプリがバックグラウンドに遷移した際のハンドラ
  void _handleOnPaused() {
    if (_timer.isActive) {
      _isTimerPaused = true;
      _timer.cancel(); // タイマーを停止する
    }
    _pausedTime = DateTime.now(); // バックグラウンドに遷移した時間を記録
    _notificationId = _scheduleLocalNotification(
        _time.difference(DateTime.utc(0, 0, 0))); // ローカル通知をスケジュール登録
  }

  /// アプリがフォアグラウンドに復帰した際のハンドラ
  void _handleOnResumed() {
    if (_isTimerPaused == null) return; // タイマーが動いてなければ何もしない
    Duration backgroundDuration =
        DateTime.now().difference(_pausedTime); // バックグラウンドでの経過時間
    // バックグラウンドでの経過時間が終了予定を超えていた場合（この場合は通知実行済みのはず）
    if (_time.difference(DateTime.utc(0, 0, 0)).compareTo(backgroundDuration) <
        0) {
      _time = DateTime.utc(0, 0, 0); // 時間をリセットする
    } else {
      //_time = _time.add(-backgroundDuration); // バックグラウンド経過時間分時間を進める
      _startTimer(); // タイマーを再開する
    }
    if (_notificationId != null)
      flutterLocalNotificationsPlugin.cancel(_notificationId); // 通知をキャンセル
    _isTimerPaused = false; // リセット
    _notificationId = null; // リセット
    _pausedTime = null;
  }
  /// タイマー終了をローカル通知
  int _scheduleLocalNotification(Duration duration) {
    print('notification scheduled.');
    flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
          android: AndroidInitializationSettings('app_icon'),
          iOS: IOSInitializationSettings()), // app_icon.pngを配置
    );
    int notificationId = DateTime.now().hashCode;
    flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        'Time is over',
        '',
        tz.TZDateTime.now(tz.local).add(duration),
        NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description',
                importance: Importance.max, priority: Priority.high),
            iOS: IOSNotificationDetails()),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    return notificationId;
  }
   */

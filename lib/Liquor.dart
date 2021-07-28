import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Liquor extends StatelessWidget {
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutterクイズ',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutterクイズ'),
        ),
        body: QuizTelling(),
      ),
    ));
  }
}

class QuizTelling extends StatefulWidget {
  const QuizTelling();

  @override
  _QuizTellingState createState() => _QuizTellingState();
}

class _QuizTellingState extends State<QuizTelling> {
  final _buttonColor = Colors.blue;
  final _borderRadius = BorderRadius.circular(10.0);

  // ボタン押下後の文字を設定する変数
  String _result = '';
  List<String> qlist = ['すごい', 'やばい', 'さすが'];
  List<List<String>> alist = [
    ['1-1', '1-2', '1-3', '1-4'],
    ['2-1', '2-2', '2-3', '2-4'],
    ['3-1', '3-2', '3-3', '3-4']
  ];
  int cnt = 0;
  int res = 0;

  void _getquestion() {}

  // タップしたボタンが不正解の場合、ボタン押下後の文字に「間違い！」を設定
  void _getResultIncorrect() {
    setState(() {
      _result = '間違い！';
    });
  }

  // タップしたボタンが正解の場合、ボタン押下後の文字に「正解」を設定
  void _getResultCorrect() {
    setState(() {
      _result = '正解！';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        constraints: BoxConstraints.expand(),
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // 問題文表示
            Container(
              child: Text(
                '好きなものは？',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              margin: EdgeInsets.only(bottom: 16.0),
            ),
            // 回答ボタンを4つ表示
            Container(
              width: 500,
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: _borderRadius,
              ),
              child: InkWell(
                borderRadius: _borderRadius,
                // ボタンタップ後に不正解の関数を呼び出し
                onTap: () {
                  _getResultIncorrect();
                },
                highlightColor: _buttonColor,
                splashColor: _buttonColor,
                child: Text(
                  '答えはA！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            Container(
              width: 500,
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: _borderRadius,
              ),
              child: InkWell(
                borderRadius: _borderRadius,
                onTap: () {
                  _getResultCorrect();
                },
                highlightColor: _buttonColor,
                splashColor: _buttonColor,
                // ボタンタップ後に正解の関数を呼び出し
                child: Text(
                  '答えはB！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            Container(
              width: 500,
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: _borderRadius,
              ),
              child: InkWell(
                borderRadius: _borderRadius,
                // ボタンタップ後に不正解の関数を呼び出し
                onTap: () {
                  _getResultIncorrect();
                },
                highlightColor: _buttonColor,
                splashColor: _buttonColor,
                child: Text(
                  '答えはC！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            Container(
              width: 500,
              margin: EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                borderRadius: _borderRadius,
              ),
              child: InkWell(
                borderRadius: _borderRadius,
                onTap: () {
                  _getResultIncorrect();
                },
                highlightColor: _buttonColor,
                splashColor: _buttonColor,
                // ボタンタップ後に不正解の関数を呼び出し
                child: Text(
                  '答えはD！',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            // ボタン押下後の文字を表示
            Text(
              _result,
              style: TextStyle(
                fontSize: 32.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Liquor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("大妖精の部屋"),
        leading: Icon(Icons.face_retouching_natural),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "./images/beer_woman.png",
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 55.0,
            ),
            Text(
              "ビールうめぇ！",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 15.0,
            ),
            TextButton(
              onPressed: () {
                context.read(questionProvider).prepare();
                return Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuestionScreen(),
                    ));
              },
              child: Text("名前あてクイズ"),
              style: textButtonStyle,
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
      ),
    );
  }
}

final ButtonStyle textButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  backgroundColor: Colors.white30,
  shadowColor: Colors.redAccent,
  minimumSize: Size(250, 50),
  textStyle: TextStyle(fontSize: 24.0),
);

class QuestionScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final questionNumber = context.read(questionProvider).questionNumberString;
    final state = useProvider(questionProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: Text("クイズよ〜"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.0,
              ),
              Text("第$questionNumber問 あたしは誰ぇ〜", style: lookTextStyle),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(state.currentQuestion.path),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnswerButton(
                    text: state.currentQuestion.answerList[0],
                    number: 0,
                  ),
                  AnswerButton(
                    text: state.currentQuestion.answerList<img class="ranking-number" src="https://techgamelife.net/wp-content/themes/jin/img/rank01.png">,
                    number: 1,
                  ),
                ],
              ),
            ],
          ),
          state.status == QuestionStatus.WAIT
              ? Center(
                  child: Image.asset(state.resultPath),
                )
              : Container(),
        ]),
      ),
    );
  }
}

final questionProvider =
    StateNotifierProvider.autoDispose((ref) => QuestionController(ref.read));

class QuestionController extends StateNotifier<QuestionState> with LocatorMixin {
  QuestionController(this._reader)
      : super(QuestionState(
          correctCount: 0,
          currentQuestion: null,
          currentQuestionResult: 0,
          questionNumber: 1,
          questionOrder: [],
          resultPath: "assets/images/pic_correct.png",
          status: QuestionStatus.ANSWER,
          soundPool: null,
          soundIdCorrect: 0,
          soundIdIncorrect: 0,
          resultComment: "",
        )) {
    prepare();
  }

  String get questionNumberString => state.questionNumber.toString();

  // 問題を初期化する
  Future<void> prepare() async {
    List<int> questionOrder = [0, 1, 2, 3];
    questionOrder.shuffle();

    state = state.copyWith(
      questionOrder: questionOrder,
      currentQuestion: questionList[questionOrder[0]],
      correctCount: 0,
      currentQuestionResult: 0,
      questionNumber: 1,
      status: QuestionStatus.ANSWER,
      resultComment: "",
      soundPool: Soundpool(),
    );

    int soundIdCorrect = await _loadSound("assets/sounds/sound_correct.mp3");
    int soundIdIncorrect = await _loadSound("assets/sounds/sound_incorrect.mp3");
    state = state.copyWith(
      soundIdCorrect: soundIdCorrect,
      soundIdIncorrect: soundIdIncorrect,
    );

  }

  Future<int> _loadSound(String soundPath) async {
    return rootBundle.load(soundPath).then((value) => state.soundPool.load(value));
  }

  Future<void> answer(int number, BuildContext context) async {
    // 答え合わせ
    if (number == state.currentQuestion.correctIndex) {
      state.soundPool.play(state.soundIdCorrect);
      state = state.copyWith(
        correctCount: state.correctCount + 1,
        resultPath: "assets/images/pic_correct.png",
        status: QuestionStatus.WAIT,
      );

    } else {
      state.soundPool.play(state.soundIdIncorrect);
      state = state.copyWith(
        resultPath: "assets/images/pic_incorrect.png",
        status: QuestionStatus.WAIT,
      );
    }

    // 待機
    await Future.delayed(Duration(seconds: 2));

    // 次の問題へ
    if (state.questionNumber == 4) {
      var resultComment = "";
      switch (state.correctCount) {
        case 0:
          resultComment = "だめよ〜";
          break;
        case 1:
          resultComment = "雑魚ね〜";
          break;
        case 2:
          resultComment = "まだまだねぇ〜";
          break;
        case 3:
          resultComment = "後少しねぇ〜";
          break;
        case 4:
          resultComment = "どんだけ〜！";
          break;
        default:
          resultComment = "だめよ〜";
      }
      state = state.copyWith(resultComment: resultComment);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ScoreScreen(),));
    } else {
      state = state.copyWith(
        questionNumber: state.questionNumber + 1,
        currentQuestion: questionList[state.questionOrder[state.questionNumber]],
        status: QuestionStatus.ANSWER,
      );
    }
  }

  @override
  void dispose() {
    state.soundPool.release();
    super.dispose();
  }

  final Reader _reader;
}

class ScoreScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(questionProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: Text("結果発表〜"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${state.correctCount}/4問正解よ〜", style: lookTextStyle,),
            SizedBox(height: 20,),
            state.correctCount == 4 ? Image.asset("assets/images/ikko.png") : Container(),
            SizedBox(height: 10,),
            Text(state.resultComment, style: lookTextStyle,),
          ],
        ),
      ),
    );
  }
}
*/

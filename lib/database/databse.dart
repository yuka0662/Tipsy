import 'package:mysql1/mysql1.dart';

class Mysql {
  //データベース接続情報
  static String host = '10.202.10.3',
      user = 'giftaringUser',
      pw = 'giftaring',
      db = 'giftaringDB';
  static int port = 3306;

  Future sql() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: host, port: port, user: user, db: db, password: pw));

    var results =
        await conn.query('SELECT nickname, email FROM users where user_id = 1');
    var _list = [];
    for (var row in results) {
      _list.add('${row.fields}');
    }
  }
  //Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: pw, db: db);

    return await MySqlConnection.connect(settings);
  }
}

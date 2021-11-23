import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() {
  getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    openDatabase(path, onCreate: (db, version) {
      db.execute('create table contacts('
          'id, INTEGER PRYMARY KEY,'
          'name TEXT,'
          'account_number INTEGER)');
    }, version: 1);
  });
}

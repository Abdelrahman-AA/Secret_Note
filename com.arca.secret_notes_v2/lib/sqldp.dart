import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String Dbpath = await getDatabasesPath();
    String path = join(Dbpath, 'userdb.db');
    Database mydb1 = await openDatabase(path,
        onCreate: _oncreate, version: 2, onUpgrade: _onupgrade);
    return mydb1;
  }

  _onupgrade(Database db, int oldversion, int newversion) async {
//     await db.execute('''
// ALTER TABLE "lastusers"
//   ADD darck BOOLEAN

// ''');

    // print("onupgrade===============");
  }

  _oncreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE "users" (
  user TEXT NOT NULL,
  password TEXT NOT NULL
)
''');
    await db.execute('''
CREATE TABLE "notes" (
  id  INTEGER  NOT NULL  PRIMARY KEY  AUTOINCREMENT ,
  user TEXT NOT NULL,
  title TEXT NOT NULL,
  note TEXT NOT NULL
)
''');
    await db.execute('''
CREATE TABLE "lastusers" (
  id  INTEGER  NOT NULL  PRIMARY KEY  AUTOINCREMENT ,
  lastuser TEXT NOT NULL,
  swit BOOLEAN NOT NULL ,
  darck BOOLEAN NOT NULL ,
  checko BOOLEAN NOT NULL ,
  lpassword TEXT NOT NULL
)
''');
    // print("onCREATE===========");
  }

  readData(String sql) async {
    Database? mydb1 = await db;
    List<Map> response = await mydb1!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb1 = await db;
    int response = await mydb1!.rawInsert(sql);
    return response;
  }

  updatetData(String sql) async {
    Database? mydb1 = await db;
    int response = await mydb1!.rawUpdate(sql);
    return response;
  }

  deletetData(String sql) async {
    Database? mydb1 = await db;
    int response = await mydb1!.rawDelete(sql);
    return response;
  }

  ondelete() async {
    String Dbpath = await getDatabasesPath();
    String path = join(Dbpath, 'userdb.db');
    await deleteDatabase(path);
    // print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
  }
}

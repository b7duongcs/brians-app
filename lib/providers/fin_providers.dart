import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FinProvider {
  static Database dbFin;

  static Future open() async {
    dbFin = await openDatabase(
      join(await getDatabasesPath(), 'fins.dbFin'),
      version: 1,
      onCreate: (Database dbFin, int version) async {
        return dbFin.execute('''
          create table Fins(
            id integer primary key autoincrement,
            location text not null,
            date text not null,
            food real not null,
            school real not null,
            bills real not null,
            other real not null,
            total real not null
          );
        ''');
      }
    );
  }

  static Future<List<Map<String, dynamic>>> getFinList() async {
    if (dbFin == null) {
      await open();
    }
    return await dbFin.query('Fins');
  }

  static Future insertFin(Map<String, dynamic> fin) async {
    await dbFin.insert('Fins', fin);
  }

  static Future deleteFin(int id) async {
    await dbFin.delete(
      'Fins',
      where : 'id = ?',
      whereArgs: [id]
    );
  }

  static Future updateFin(Map<String, dynamic> fin) async {
    await dbFin.update(
      'Fins',
      fin,
      where: 'id = ?',
      whereArgs: [fin['id']]
    );
  }

}
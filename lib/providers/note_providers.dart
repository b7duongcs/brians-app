import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteProvider {
  static Database dbNote;

  static Future open() async {
    dbNote = await openDatabase(
      join(await getDatabasesPath(), 'notes.dbNote'),
      version: 1,
      onCreate: (Database dbNote, int version) async {
        return dbNote.execute('''
          create table Notes(
            id integer primary key autoincrement,
            title text not null,
            tag text not null,
            text text,
            date text not null,
            time text not null
          );
        ''');
      }
    );
  }

  static Future<List<Map<String, dynamic>>> getNoteList() async {
    if (dbNote == null) {
      await open();
    }
    return await dbNote.query('Notes');
  }

  static Future insertNote(Map<String, dynamic> note) async {
    await dbNote.insert('Notes', note);
  }

  static Future deleteNote(int id) async {
    await dbNote.delete(
      'Notes',
      where : 'id = ?',
      whereArgs: [id]
    );
  }

  static Future updateNote(Map<String, dynamic> note) async {
    await dbNote.update(
      'Notes',
      note,
      where: 'id = ?',
      whereArgs: [note['id']]
    );
  }

}

class TagProvider {
  static Database dbTag;

  static Future open() async {
    dbTag = await openDatabase(
      join(await getDatabasesPath(), 'tags.dbTag'),
      version: 10,
      onCreate: (Database dbTag, int version) async {
        return dbTag.execute('''
          create table Tags(
            id integer primary key autoincrement,
            tag text not null
          );
        ''');
      }
    );
  }

  static Future<List<Map<String, dynamic>>> getTagList() async {
    if (dbTag == null) {
      await open();
    }
    return await dbTag.query('Tags');
  }

  static Future insertTag(Map<String, dynamic> tag) async {
    await dbTag.insert('Tags', tag);
  }

  static Future deleteTag(int id) async {
    await dbTag.delete(
      'Tags',
      where : 'id = ?',
      whereArgs: [id]
    );
  }

  static Future updateTag(Map<String, dynamic> tag) async {
    await dbTag.update(
      'Tags',
      tag,
      where: 'id = ?',
      whereArgs: [tag['id']]
    );
  }
}
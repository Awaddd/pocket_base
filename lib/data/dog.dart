import 'package:pocket_base/models/dog.dart';
import 'package:sqflite/sqflite.dart';

class Dogs {
  static String tableName = 'dogs';
  final Database db;

  Dogs(this.db);

  Future<void> createTable() async {
    await db.execute(
      '''
        CREATE TABLE IF NOT EXISTS $tableName (
          id TEXT PRIMARY KEY,
          name TEXT NOT NULL
        ) WITHOUT ROWID;
      ''',
    );
  }

  Future<void> deleteTable() async {
    await db.execute(
      '''
        DROP TABLE $tableName;
      ''',
    );
  }

  Future<List<Dog>> fetchAll() async {
    final dogs = await db.rawQuery(
      '''
        SELECT * FROM $tableName;
      ''',
    );

    return dogs.map((dog) => Dog.fromLocalDatabase(dog)).toList();
  }

  Future<Dog> fetch(String id) async {
    final dogs = await db.rawQuery(
      '''
        SELECT *
        FROM $tableName
        WHERE id = "$id"
      ''',
    );

    return Dog.fromLocalDatabase(dogs.first);
  }

  Future<Dog> fetchByName(String name) async {
    final dogs = await db.rawQuery(
      '''
        SELECT *
        FROM $tableName
        WHERE name = "$name"
      ''',
    );

    return Dog.fromLocalDatabase(dogs.first);
  }

  Future<int> create(String id, String name) async {
    return db.rawInsert(
      '''
        INSERT INTO $tableName (id, name) VALUES (?, ?)
      ''',
      [id, name],
    );
  }

  Future<int> update(String id, String name) async {
    return db.rawUpdate(
      '''
        UPDATE $tableName
        SET name = "$name"
        WHERE id = "$id"
      ''',
    );
  }

  Future<int> delete(String id) async {
    return db.rawDelete(
      '''
        DELETE
        FROM $tableName
        WHERE id = "$id"
      ''',
    );
  }
}

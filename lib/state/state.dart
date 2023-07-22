import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:pocket_base/data/dog.dart';
import 'package:sqflite/sqflite.dart';

final databaseProvider = Provider((ref) async {
  return openDatabase(
    join(await getDatabasesPath(), 'pb_demo.db'),
    onCreate: (db, version) async {
      await Dogs(db).createTable();
    },
    version: 1,
  );
});

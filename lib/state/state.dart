import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:pocket_base/data/dog.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sqflite/sqflite.dart';

// pocketbase provider
final pocketbase = Provider((ref) {
  const url = 'http://10.0.2.2:8090';
  return PocketBase(url);
});

// local sqflite provider
final databaseProvider = Provider((ref) async {
  return openDatabase(
    join(await getDatabasesPath(), 'pb_demo.db'),
    onCreate: (db, version) async {
      await Dogs(db).createTable();
    },
    version: 1,
  );
});

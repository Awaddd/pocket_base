import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_base/data/dog.dart';
import 'package:pocket_base/models/dog.dart';
import 'package:pocket_base/state/state.dart';

class DogsController {
  DogsController(this.ref);

  final Ref ref;

  Future<List<Dog>> fetchAll() async {
    final db = await ref.read(database);
    return Dogs(db).fetchAll();
  }

  Future<Dog> fetch(int id) async {
    final db = await ref.read(database);
    return Dogs(db).fetch(id);
  }

  Future<int> create(String name) async {
    final db = await ref.read(database);
    return Dogs(db).create(name);
  }

  Future<int> update(int id, String name) async {
    final db = await ref.read(database);
    return Dogs(db).update(id, name);
  }

  Future<int> delete(int id) async {
    final db = await ref.read(database);
    return Dogs(db).delete(id);
  }
}

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

  Future<Dog> fetch(String id) async {
    final db = await ref.read(database);
    return Dogs(db).fetch(id);
  }

  Future<Dog> fetchByName(String name) async {
    final db = await ref.read(database);
    return Dogs(db).fetchByName(name);
  }

  Future<int> create(String name) async {
    final db = await ref.read(database);

    final Map<String, dynamic> body = {"name": name};

    final pb = ref.read(pocketbase);
    final record = await pb.collection('dogs').create(body: body);
    final dog = Dog.fromNetwork(record);
    return Dogs(db).create(dog.id, name);
  }

  Future<int> update(String id, String name) async {
    final db = await ref.read(database);
    return Dogs(db).update(id, name);
  }

  Future<int> delete(String id) async {
    final db = await ref.read(database);
    final pb = ref.read(pocketbase);
    await pb.collection('dogs').delete(id);

    return Dogs(db).delete(id);
  }
}
